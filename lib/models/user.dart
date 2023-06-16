import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String firstName,
    required String lastName,
    required String email,
    String? id,
    String? avatarURL,
    String? gender,
    DateTime? birthDate,
    String? phoneNumber,
    String? currentVolunteeringId,
    List<String>? favoriteVolunteeringsIds,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
