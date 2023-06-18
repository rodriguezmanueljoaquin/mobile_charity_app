import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:mobile_charity_app/api/ser_manos_api.dart';
import 'package:mobile_charity_app/models/user.dart';
import 'package:mobile_charity_app/utils/logger.dart';

class UserProvider extends ChangeNotifier {
  UserModel? user;
  GeoPoint? userLocation;

  Future<UserModel?> login({
    required String email,
    required String password,
  }) async {
    UserModel? user =
        await SerManosApi().loginUser(email: email, password: password);
    this.user = user;
    return user;
  }

  Future<UserModel?> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    UserModel? user = await SerManosApi().registerUser(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName);
    this.user = user;
    return user;
  }

  Future<bool> setVolunteeringAsFavorite({
    required String volunteeringId,
    required bool isFavorite,
  }) async {
    try {
      await SerManosApi().setVolunteeringAsFavorite(
        userId: user!.id,
        volunteeringId: volunteeringId,
        isFavorite: isFavorite,
      );

      if (isFavorite) {
        user = user?.copyWith(
          favoriteVolunteeringsIds: [
            ...user!.favoriteVolunteeringsIds!,
            volunteeringId
          ],
        );
      } else {
        user = user?.copyWith(
          favoriteVolunteeringsIds:
              user!.favoriteVolunteeringsIds!.where((element) {
            return element != volunteeringId;
          }).toList(),
        );
      }

      return true;
    } catch (e) {
      logger.e(e);
      return false;
    }
  }

  Future<void> fetchUser() async {
    if (user?.id == null) return;

    user = await SerManosApi().getUserById(id: user!.id);
    notifyListeners();
  }

  Future<void> loadUserFromCache() async {
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      user = UserModel(id: firebaseUser.uid);
      await fetchUser();
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    user = null;
  }
}
