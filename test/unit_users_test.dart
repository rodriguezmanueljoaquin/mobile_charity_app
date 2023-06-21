import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_charity_app/api/ser_manos_api.dart';
import 'package:mobile_charity_app/api/ser_manos_storage.dart';
import 'package:mobile_charity_app/models/user.dart';
import 'package:mobile_charity_app/providers/user_provider.dart';

import 'mocks/mock_firebase_analytics.dart';
import 'mocks/mock_user_provider.dart';

Future<UserModel> userSetup(UserProvider userProvider) async {
  // Populate the fake database.
  final fakeFirestore = FakeFirebaseFirestore();
  String userId = await fakeFirestore
      .collection('users')
      .add(MockUserProvider().user!.toJson())
      .then((value) => value.id);

  SerManosApi().setFirestore(fakeFirestore);

  final fakeStorage = MockFirebaseStorage();
  SerManosStorage().setStorage(fakeStorage);

  userProvider.setFirebaseAnalytics(MockFirebaseAnalytics());
  userProvider.user = MockUserProvider().user!.copyWith(id: userId);

  UserModel? user = userProvider.user;
  assert(user != null);
  assert(user!.id == userId);

  return user!;
}

void main() {
  test("add favorite volunteering to user", () async {
    UserProvider userProvider = UserProvider();
    UserModel user = await userSetup(userProvider);

    String volunteeringId = "ASDASD";
    // ADD TO FAVORITE
    assert(user.favoriteVolunteeringsIds!.isEmpty);
    await userProvider.setVolunteeringAsFavorite(
        volunteeringId: volunteeringId, isFavorite: true);
    await userProvider.fetchUser();
    user = userProvider.user!; //update
    assert(user.favoriteVolunteeringsIds != null);
    assert(user.favoriteVolunteeringsIds!.contains(volunteeringId));

    // REMOVE FROM FAVORITE
    await userProvider.setVolunteeringAsFavorite(
        volunteeringId: volunteeringId, isFavorite: false);
    await userProvider.fetchUser();
    user = userProvider.user!; //update
    assert(user.favoriteVolunteeringsIds != null);
    assert(!user.favoriteVolunteeringsIds!.contains(volunteeringId));
  });

  test("update user phone data", () async {
    UserProvider userProvider = UserProvider();
    UserModel user = await userSetup(userProvider);

    assert(user.phoneNumber == null);
    await userProvider.updateProfile(phoneNumber: "123456789");
    await userProvider.fetchUser();
    user = userProvider.user!; //update
    assert(user.phoneNumber == "123456789");
  });

  test("update user gender data", () async {
    UserProvider userProvider = UserProvider();
    UserModel user = await userSetup(userProvider);

    assert(user.gender == null);
    await userProvider.updateProfile(gender: "ASD");
    await userProvider.fetchUser();
    user = userProvider.user!; //update
    assert(user.gender == "ASD");
  });

  test("update user birth date", () async {
    UserProvider userProvider = UserProvider();
    UserModel user = await userSetup(userProvider);

    assert(user.gender == null);
    DateTime birthDate = DateTime.now();
    await userProvider.updateProfile(birthDate: birthDate);
    await userProvider.fetchUser();
    user = userProvider.user!; //update
    expect(user.birthDate, birthDate);
  });

  test("update user data", () async {
    UserProvider userProvider = UserProvider();
    UserModel user = await userSetup(userProvider);

    assert(user.gender == null);
    DateTime birthDate = DateTime.now();
    await userProvider.updateProfile(
        gender: "ASD", phoneNumber: "123456789", birthDate: birthDate);
    await userProvider.fetchUser();
    user = userProvider.user!; //update
    expect(user.gender, "ASD");
    expect(user.phoneNumber, "123456789");
    expect(user.birthDate, birthDate);
  });
}
