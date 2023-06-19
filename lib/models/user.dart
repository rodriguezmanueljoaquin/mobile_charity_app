import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:mobile_charity_app/utils/firestore.dart';
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
    String? avatarImageKey,
    String? gender,
    @TimestampConverter() DateTime? birthDate,
    String? phoneNumber,
    String? currentVolunteeringId,
    List<String>? favoriteVolunteeringsIds,
    @JsonKey(ignore: true) String? downloadAvatarURL,
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
        avatarImageKey,
        gender,
        birthDate,
        phoneNumber
      ].every((element) => element != null);

  Future<UserModel> fetchDownloadAvatarURL() async {
    if (avatarImageKey == null) return this;

    final String avatarURL = await getDownloadURL(key: avatarImageKey!);
    return copyWith(downloadAvatarURL: avatarURL);
  }
}
