import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:logger/logger.dart';
import 'package:mobile_charity_app/models/news.dart';
import 'package:mobile_charity_app/models/user.dart';
import 'package:mobile_charity_app/models/volunteering.dart';
import 'package:mobile_charity_app/utils/firestore.dart';
import 'package:mobile_charity_app/utils/logger.dart';

class SerManosApi {
  // singleton
  static final SerManosApi _serManosApi = SerManosApi._internal();

  factory SerManosApi() {
    return _serManosApi;
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

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(newUser.toJson());

      return newUser.copyWith(id: userCredential.user!.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        logger.d('The password provided is too weak.');
        return null;
      } else if (e.code == 'email-already-in-use') {
        logger.d('The account already exists for that email.');
        return null;
      }
    } catch (e) {
      logger.e(e);
      return null;
    }

    return null;
  }

  Future<UserModel?> getUserById({
    required String id,
  }) async {
    try {
      DocumentSnapshot documentSnapshot =
          await FirebaseFirestore.instance.collection('users').doc(id).get();

      return await UserModel.fromJson(buildProperties(documentSnapshot))
          .fetchDownloadAvatarURL();
    } catch (e) {
      logger.e(e);
      return null;
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
      if (e.code == 'user-not-found') {
        logger.w('No user found for that email.');
        return null;
      } else if (e.code == 'wrong-password') {
        logger.w('Wrong password provided for that user.');
        return null;
      }
    } catch (e) {
      logger.e(e);
      return null;
    }

    return null;
  }

  Future<List<VolunteeringModel>> getVolunteerings() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('volunteerings')
          .orderBy('createdAt', descending: false)
          .get();

      List<Future<VolunteeringModel>> volunteeringFutures = querySnapshot.docs
          .map((e) => VolunteeringModel.fromJson(buildProperties(e)).fetchDownloadImageURL())
          .toList();

      return await Future.wait(volunteeringFutures);
    } catch (e) {
      logger.e(e);
      return [];
    }
  }

  Future<List<NewsModel>> getNews() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('news').get();

      return querySnapshot.docs
          .map((e) => NewsModel.fromJson(buildProperties(e)))
          .toList();
    } catch (e) {
      logger.d(e);
      return [];
    }
  }

  Future<VolunteeringModel?> getVolunteeringById({
    required String volunteeringId,
  }) async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('volunteerings')
          .doc(volunteeringId)
          .get();

      return await VolunteeringModel.fromJson(buildProperties(documentSnapshot)).fetchDownloadImageURL();
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  Future<bool> setVolunteeringAsFavorite({
    required String userId,
    required String volunteeringId,
    required bool isFavorite,
  }) async {
    try {
      FieldValue fieldValue = isFavorite
          ? FieldValue.arrayUnion([volunteeringId])
          : FieldValue.arrayRemove([volunteeringId]);

      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'favoriteVolunteeringsIds': fieldValue,
      });

      return true;
    } catch (e) {
      logger.e(e);
      return false;
    }
  }

  Future<void> applyToVolunteering({
    required String userId,
    required String volunteeringId,
  }) async {
    // Decrease vacancies by 1 and set current volunteering id
    // Check that vacancies > 0
    DocumentSnapshot volunteeringSnapshot = await FirebaseFirestore.instance
        .collection('volunteerings')
        .doc(volunteeringId)
        .get();

    VolunteeringModel volunteering =
        VolunteeringModel.fromJson(buildProperties(volunteeringSnapshot));

    if (volunteering.vacancies <= 0) {
      throw Exception('No vacancies available');
    }

    await FirebaseFirestore.instance
        .collection('volunteerings')
        .doc(volunteeringId)
        .update({
      'vacancies': volunteering.vacancies - 1,
      'volunteersIds': FieldValue.arrayUnion([userId]),
    });

    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'currentVolunteeringId': volunteeringId,
    });
  }

  Future<void> abandonVolunteering({
    required String userId,
    required String volunteeringId,
  }) async {
    // Increase vacancies by 1 and set current volunteering id to null
    await FirebaseFirestore.instance
        .collection('volunteerings')
        .doc(volunteeringId)
        .update({
      'vacancies': FieldValue.increment(1),
      'volunteersIds': FieldValue.arrayRemove([userId]),
    });

    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'currentVolunteeringId': null,
    });
  }

  Future<bool> updateProfileInfo({
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
        await uploadFile(key: key, file: avatar);

        updatedUser = updatedUser.copyWith(avatarImageKey: key);
      }

      await FirebaseFirestore.instance
          .collection('users')
          .doc(updatedUser.id)
          .update(updatedUser.toJson());

      return true;
    } on FirebaseException catch (e) {
      logger.e('Error updating user: ${e.message}');
      return false;
    } catch (e) {
      logger.e(e);
      return false;
    }
  }
}