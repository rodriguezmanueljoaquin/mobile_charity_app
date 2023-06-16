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
      imageURL: json['imageURL'] as String,
      category: json['category'] as String,
      about: json['about'] as String,
      address: json['address'] as String,
      requirements: (json['requirements'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      availability: (json['availability'] as List<dynamic>)
          .map((e) => Availability.fromJson(e as Map<String, dynamic>))
          .toList(),
      vacancies: json['vacancies'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      volunteerIds: (json['volunteerIds'] as List<dynamic>)
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
      'imageURL': instance.imageURL,
      'category': instance.category,
      'about': instance.about,
      'address': instance.address,
      'requirements': instance.requirements,
      'availability': instance.availability,
      'vacancies': instance.vacancies,
      'createdAt': instance.createdAt.toIso8601String(),
      'volunteerIds': instance.volunteerIds,
      'location': const GeoPointConverter().toJson(instance.location),
    };
