import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SerManosApi {
  // singleton
  static final SerManosApi _serManosApi = SerManosApi._internal();

  factory SerManosApi() {
    return _serManosApi;
  }

  SerManosApi._internal();

  // methods
  Future<bool> registerUser(
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
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(
        {
          'first_name': firstName,
          'last_name': lastName,
          'email': email,
          'avatar_url': null
        },
      );

      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        return false;
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }

    return false;
  }
}
