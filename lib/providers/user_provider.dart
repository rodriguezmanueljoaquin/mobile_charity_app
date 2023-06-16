import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_charity_app/api/ser_manos_api.dart';
import 'package:mobile_charity_app/models/user.dart';

class UserProvider {
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
        userId: user!.id!,
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
      print(e);
      return false;
    }

  }
}
