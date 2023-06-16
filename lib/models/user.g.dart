// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserModel _$$_UserModelFromJson(Map<String, dynamic> json) => _$_UserModel(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      id: json['id'] as String?,
      avatarURL: json['avatarURL'] as String?,
      gender: json['gender'] as String?,
      birthDate: json['birthDate'] == null
          ? null
          : DateTime.parse(json['birthDate'] as String),
      phoneNumber: json['phoneNumber'] as String?,
      currentVolunteeringId: json['currentVolunteeringId'] as String?,
      favoriteVolunteeringsIds:
          (json['favoriteVolunteeringsIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
    );

Map<String, dynamic> _$$_UserModelToJson(_$_UserModel instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'id': instance.id,
      'avatarURL': instance.avatarURL,
      'gender': instance.gender,
      'birthDate': instance.birthDate?.toIso8601String(),
      'phoneNumber': instance.phoneNumber,
      'currentVolunteeringId': instance.currentVolunteeringId,
      'favoriteVolunteeringsIds': instance.favoriteVolunteeringsIds,
    };
