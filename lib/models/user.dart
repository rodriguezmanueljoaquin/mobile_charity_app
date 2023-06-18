import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:mobile_charity_app/utils/timestamp_converter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    String? firstName,
    String? lastName,
    String? email,
    String? avatarURL,
    String? gender,
    @TimestampConverter() DateTime? birthDate,
    String? phoneNumber,
    String? currentVolunteeringId,
    List<String>? favoriteVolunteeringsIds,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  const UserModel._();

  String get fullName => "$firstName $lastName";

  // all fields are required and must be non-null
  bool get hasCompleteProfile => [
        firstName,
        lastName,
        email,
        avatarURL,
        gender,
        birthDate,
        phoneNumber
      ].every((element) => element != null);
}
