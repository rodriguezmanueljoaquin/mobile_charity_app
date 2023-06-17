import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile_charity_app/models/news.dart';
import 'package:mobile_charity_app/models/user.dart';
import 'package:mobile_charity_app/models/volunteering.dart';
import 'package:mobile_charity_app/utils/firestore.dart';

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

      print(userCredential);
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
        print('The password provided is too weak.');
        return null;
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        return null;
      }
    } catch (e) {
      print(e);
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

      return UserModel.fromJson(buildProperties(documentSnapshot));
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<UserModel?> loginUser(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      UserModel? user = await getUserById(id: userCredential.user!.uid);

      print(user);

      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        return null;
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }

    return null;
  }

  Future<List<VolunteeringModel>> getVolunteerings() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('volunteerings').get();

      return querySnapshot.docs
          .map((e) => VolunteeringModel.fromJson(buildProperties(e)))
          .toList();
    } catch (e) {
      print(e);
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
      print(e);
      return [];
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
      print(e);
      return false;
    }
  }

  Future<bool> applyToVolunteering({
    required String userId,
    required String volunteeringId,
  }) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'currentVolunteeringId': volunteeringId,
      });

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> updateProfileInfo(UserModel user) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.id)
          .update(user.toJson());

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
