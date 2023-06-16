import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_charity_app/models/availability.dart';
import 'package:mobile_charity_app/utils/geopoint_converter.dart';

part 'volunteering.freezed.dart';
part 'volunteering.g.dart';

@freezed
class VolunteeringModel with _$VolunteeringModel {
  const factory VolunteeringModel({
    required String id,
    required String title,
    required String description,
    required String imageURL,
    required String category,
    required String about,
    required String address,
    required List<String> requirements,
    required List<Availability> availability,
    required int vacancies,
    required DateTime createdAt,
    required List<String> volunteerIds,
    @GeoPointConverter() required GeoPoint location,
  }) = _VolunteeringModel;

  factory VolunteeringModel.fromJson(Map<String, dynamic> json) =>
      _$VolunteeringModelFromJson(json);
}
