import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobile_charity_app/api/ser_manos_api.dart';
import 'package:mobile_charity_app/models/user.dart';
import 'package:mobile_charity_app/utils/geolocator.dart';
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

    await FirebaseAnalytics.instance.logLogin(loginMethod: 'email');
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

    await FirebaseAnalytics.instance.logSignUp(signUpMethod: 'email');

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

      // log event
      await FirebaseAnalytics.instance.logEvent(
        name: 'favorite_volunteering',
        parameters: {
          'volunteering_id': volunteeringId,
          'is_favorite': isFavorite.toString(),
        },
      );

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
      await FirebaseAnalytics.instance.logLogin(loginMethod: 'cache');
    }
  }

  Future<void> logout() async {
    await FirebaseAnalytics.instance.logEvent(name: 'logout');

    await FirebaseAuth.instance.signOut();
    user = null;
  }

  // update only properties that are not null
  Future<void> updateProfile({
    String? email,
    String? gender,
    DateTime? birthDate,
    String? phoneNumber,
    File? avatar,
  }) async {
    final bool changedEmail = email != null && email != user!.email;
    UserModel updatedUser = user!.copyWith();

    if (changedEmail) {
      updatedUser = updatedUser.copyWith(email: email);
    }

    if (gender != null) {
      updatedUser = updatedUser.copyWith(gender: gender);
    }

    if (birthDate != null) {
      updatedUser = updatedUser.copyWith(birthDate: birthDate);
    }

    if (phoneNumber != null) {
      updatedUser = updatedUser.copyWith(phoneNumber: phoneNumber);
    }

    await SerManosApi().updateProfileInfo(
        updatedUser: updatedUser, changedEmail: changedEmail, avatar: avatar);
    await fetchUser();
  }

  Future<GeoPoint?> loadLocation() async {
    Position? position = await getCurrentPosition();
    if (position != null) {
      userLocation = GeoPoint(position.latitude, position.longitude);

      await FirebaseAnalytics.instance.logEvent(name: 'userLocation');
      logger.d(
          'latitude: ${userLocation!.latitude}, longitude: ${userLocation!.longitude}');

      notifyListeners();

      return userLocation;
    }

    return null;
  }
}
