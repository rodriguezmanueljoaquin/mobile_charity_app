import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile_charity_app/models/user.dart';

class SerManosApi {
  // singleton
  static final SerManosApi _serManosApi = SerManosApi._internal();

  factory SerManosApi() {
    return _serManosApi;
  }

  SerManosApi._internal();

  // methods
  Future<UserModel?> registerUser(
      {required String email,
      required String password,
      required String firstName,
      required String lastName}) async {
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

      if (documentSnapshot.exists) {
        return UserModel(
          firstName: documentSnapshot.get('firstName'),
          lastName: documentSnapshot.get('lastName'),
          email: documentSnapshot.get('email'),
          avatarURL: documentSnapshot.get('avatarURL'),
          id: documentSnapshot.id,
        );
      }
    } catch (e) {
      print(e);
      return null;
    }

    return null;
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
}
