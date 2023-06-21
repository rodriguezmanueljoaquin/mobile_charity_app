import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile_charity_app/api/ser_manos_storage.dart';
import 'package:mobile_charity_app/models/exceptions.dart';
import 'package:mobile_charity_app/models/news.dart';
import 'package:mobile_charity_app/models/user.dart';
import 'package:mobile_charity_app/models/volunteering.dart';
import 'package:mobile_charity_app/utils/logger.dart';

Map<String, dynamic> buildProperties(DocumentSnapshot<Object?> doc) {
  Map<String, dynamic> properties = doc.data() as Map<String, dynamic>;
  properties['id'] = doc.id;
  return properties;
}

class SerManosApi {
  // singleton
  static final SerManosApi _serManosApi = SerManosApi._internal();
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;

  factory SerManosApi() {
    return _serManosApi;
  }

  void setFirestore(FirebaseFirestore firestore) {
    // method for testing purposes
    _firestore = firestore;
  }

  SerManosApi._internal();

  // methods
  Future<UserModel?> registerUser({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    // save user in Firebase Auth & other data in Firestore users collection
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      logger.d(userCredential);
      // save user data in Firestore
      UserModel newUser = UserModel(
        firstName: firstName,
        lastName: lastName,
        email: email,
        id: userCredential.user!.uid,
        favoriteVolunteeringsIds: [],
      );

      await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(newUser.toJson());

      return newUser.copyWith(id: userCredential.user!.uid);
    } on FirebaseAuthException catch (e) {
      String message = e.message ?? 'Error registrando usuario';
      if (e.code == 'weak-password') {
        logger.d('The password provided is too weak.');
        message = 'La contraseña es muy débil';
      } else if (e.code == 'email-already-in-use') {
        logger.d('The account already exists for that email.');
        message = 'Ya existe una cuenta con ese correo';
      }

      throw FormException(message);
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  Future<UserModel?> getUserById({
    required String id,
  }) async {
    try {
      DocumentSnapshot documentSnapshot =
          await _firestore.collection('users').doc(id).get();

      return await UserModel.fromJson(buildProperties(documentSnapshot))
          .fetchDownloadAvatarURL();
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  Future<UserModel?> loginUser(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      UserModel? user = await getUserById(id: userCredential.user!.uid);

      logger.d(user);

      return user;
    } on FirebaseAuthException catch (e) {
      String message = e.message ?? 'Error iniciando sesión';

      if (e.code == 'user-not-found') {
        logger.w('No user found for that email.');
        message = 'No se encontró un usuario con ese correo';
      } else if (e.code == 'wrong-password') {
        logger.w('Wrong password provided for that user.');
        message = 'Contraseña incorrecta';
      }

      throw FormException(message);
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  Future<List<VolunteeringModel>> getVolunteerings() async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('volunteerings')
          .orderBy('createdAt', descending: true)
          .get();

      List<Future<VolunteeringModel>> volunteeringFutures = querySnapshot.docs
          .map((e) => VolunteeringModel.fromJson(buildProperties(e))
              .fetchDownloadImageURL())
          .toList();

      return await Future.wait(volunteeringFutures);
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  Future<List<NewsModel>> getNews() async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('news')
          .orderBy('createdAt', descending: true)
          .get();

      List<Future<NewsModel>> newsFutures = querySnapshot.docs
          .map((e) =>
              NewsModel.fromJson(buildProperties(e)).fetchDownloadImageURL())
          .toList();

      return await Future.wait(newsFutures);
    } catch (e) {
      logger.d(e);
      rethrow;
    }
  }

  Future<VolunteeringModel?> getVolunteeringById({
    required String volunteeringId,
  }) async {
    try {
      DocumentSnapshot documentSnapshot = await _firestore
          .collection('volunteerings')
          .doc(volunteeringId)
          .get();

      return await VolunteeringModel.fromJson(buildProperties(documentSnapshot))
          .fetchDownloadImageURL();
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  Future<void> setVolunteeringAsFavorite({
    required String userId,
    required String volunteeringId,
    required bool isFavorite,
  }) async {
    try {
      FieldValue fieldValue = isFavorite
          ? FieldValue.arrayUnion([volunteeringId])
          : FieldValue.arrayRemove([volunteeringId]);

      await _firestore.collection('users').doc(userId).update({
        'favoriteVolunteeringsIds': fieldValue,
      });
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  Future<void> applyToVolunteering({
    required String userId,
    required String volunteeringId,
  }) async {
    DocumentSnapshot volunteeringSnapshot =
        await _firestore.collection('volunteerings').doc(volunteeringId).get();

    VolunteeringModel volunteering =
        VolunteeringModel.fromJson(buildProperties(volunteeringSnapshot));

    // Check that vacancies > 0
    if (volunteering.vacancies <= 0) {
      throw Exception('No vacancies available');
    }

    await _firestore.collection('volunteerings').doc(volunteeringId).update({
      'volunteersIds': FieldValue.arrayUnion([userId]),
    });

    await _firestore.collection('users').doc(userId).update({
      'currentVolunteeringId': volunteeringId,
    });
  }

  Future<void> abandonVolunteering({
    required String userId,
    required String volunteeringId,
  }) async {
    await _firestore.collection('volunteerings').doc(volunteeringId).update({
      'volunteersIds': FieldValue.arrayRemove([userId]),
      'participantsIds':
          FieldValue.arrayRemove([userId]), // maybe user is participant
    });

    await _firestore.collection('users').doc(userId).update({
      'currentVolunteeringId': null,
    });
  }

  Future<void> updateProfileInfo({
    required UserModel updatedUser,
    required bool changedEmail,
    File? avatar,
  }) async {
    try {
      if (changedEmail) {
        await FirebaseAuth.instance.currentUser!
            .updateEmail(updatedUser.email!);
      }

      if (avatar != null) {
        final String key =
            'users/${updatedUser.id}'; // should not change but just in case
        await SerManosStorage().uploadFile(key: key, file: avatar);

        updatedUser = updatedUser.copyWith(avatarImageKey: key);
      }

      await _firestore
          .collection('users')
          .doc(updatedUser.id)
          .update(updatedUser.toJson());
    } on FirebaseException catch (e) {
      String message = 'Error actualizando el perfil';
      if (e.plugin == 'firebase_storage') {
        message = 'La imagen debe ocupar menos de 5MB';
      }
      logger.e(message);
      throw FormException(message);
    } catch (e) {
      logger.e(e);
      rethrow;
    }
    
    catch (e) {
      logger.e(e);
      rethrow;
    }
  }
}
