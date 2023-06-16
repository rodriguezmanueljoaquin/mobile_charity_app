import 'package:flutter/cupertino.dart';
import 'package:mobile_charity_app/models/user.dart';

class UserProvider {
  UserModel? _user;

  UserModel? get user => _user;

  void setUser(UserModel user) {
    _user = user;
  }
}
