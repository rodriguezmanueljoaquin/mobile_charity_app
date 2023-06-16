import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_charity_app/models/user.dart';

class UserProvider {
  UserModel? user;
  GeoPoint? userLocation;
}
