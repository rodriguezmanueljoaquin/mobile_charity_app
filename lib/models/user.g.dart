// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserModel _$$_UserModelFromJson(Map<String, dynamic> json) => _$_UserModel(
      id: json['id'] as String,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      email: json['email'] as String?,
      avatarURL: json['avatarURL'] as String?,
      gender: json['gender'] as String?,
      birthDate: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['birthDate'], const TimestampConverter().fromJson),
      phoneNumber: json['phoneNumber'] as String?,
      currentVolunteeringId: json['currentVolunteeringId'] as String?,
      favoriteVolunteeringsIds:
          (json['favoriteVolunteeringsIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
    );

Map<String, dynamic> _$$_UserModelToJson(_$_UserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'avatarURL': instance.avatarURL,
      'gender': instance.gender,
      'birthDate': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.birthDate, const TimestampConverter().toJson),
      'phoneNumber': instance.phoneNumber,
      'currentVolunteeringId': instance.currentVolunteeringId,
      'favoriteVolunteeringsIds': instance.favoriteVolunteeringsIds,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
