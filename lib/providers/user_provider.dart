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
}
