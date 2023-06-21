import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:mobile_charity_app/models/user.dart';
import 'package:mobile_charity_app/providers/user_provider.dart';

class MockUserProvider extends ChangeNotifier implements UserProvider {
  @override
  UserModel? user = const UserModel(
      id: "1",
      firstName: "John",
      lastName: "Doe",
      email: "asdaaa@asdasd.aaa",
      favoriteVolunteeringsIds: []);

  @override
  GeoPoint? userLocation = const GeoPoint(1, 1);

  @override
  Future<void> fetchUser() {
    return Future.value();
  }

  @override
  Future<UserModel?> login({required String email, required String password}) {
    return Future.value(user);
  }

  @override
  Future<UserModel?> register(
      {required String email,
      required String password,
      required String firstName,
      required String lastName}) {
    return Future.value(user);
  }

  @override
  Future<bool> setVolunteeringAsFavorite(
      {required String volunteeringId, required bool isFavorite}) {
    return Future.value(false);
  }

  @override
  Future<void> loadUserFromCache() {
    return Future.value();
  }

  @override
  Future<void> logout() {
    return Future.value();
  }

  @override
  Future<void> updateProfile(
      {String? email,
      String? gender,
      DateTime? birthDate,
      String? phoneNumber,
      File? avatar}) {
    return Future.value();
  }

  @override
  Future<GeoPoint?> loadLocation() {
    return Future.value(userLocation);
  }

  @override
  void setFirebaseAnalytics(FirebaseAnalytics firebaseAnalytics) {}
}
