// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'volunteering.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_VolunteeringModel _$$_VolunteeringModelFromJson(Map<String, dynamic> json) =>
    _$_VolunteeringModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      imageKey: json['imageKey'] as String,
      category: json['category'] as String,
      about: json['about'] as String,
      address: json['address'] as String,
      requirements: json['requirements'] as String,
      availability: (json['availability'] as List<dynamic>)
          .map((e) => Availability.fromJson(e as Map<String, dynamic>))
          .toList(),
      maxVacancies: json['maxVacancies'] as int,
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp),
      volunteersIds: (json['volunteersIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      participantsIds: (json['participantsIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      location:
          const GeoPointConverter().fromJson(json['location'] as GeoPoint),
    );

Map<String, dynamic> _$$_VolunteeringModelToJson(
        _$_VolunteeringModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'imageKey': instance.imageKey,
      'category': instance.category,
      'about': instance.about,
      'address': instance.address,
      'requirements': instance.requirements,
      'availability': instance.availability,
      'maxVacancies': instance.maxVacancies,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'volunteersIds': instance.volunteersIds,
      'participantsIds': instance.participantsIds,
      'location': const GeoPointConverter().toJson(instance.location),
    };
