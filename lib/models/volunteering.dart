import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_charity_app/models/availability.dart';
import 'package:mobile_charity_app/utils/firestore.dart';
import 'package:mobile_charity_app/utils/geopoint_converter.dart';
import 'package:mobile_charity_app/utils/timestamp_converter.dart';

part 'volunteering.freezed.dart';
part 'volunteering.g.dart';

@freezed
class VolunteeringModel with _$VolunteeringModel {
  const factory VolunteeringModel({
    required String id,
    required String title,
    required String description,
    required String imageKey,
    required String category,
    required String about,
    required String address,
    required String requirements,
    required List<Availability> availability,
    required int vacancies,
    @TimestampConverter() required DateTime createdAt,
    required List<String> volunteersIds,
    @GeoPointConverter() required GeoPoint location,
    @JsonKey(ignore: true) String? downloadImageURL,
  }) = _VolunteeringModel;

  factory VolunteeringModel.fromJson(Map<String, dynamic> json) =>
      _$VolunteeringModelFromJson(json);

  const VolunteeringModel._();

  Future<VolunteeringModel> fetchDownloadImageURL() async {
    final String imageURL = await getDownloadURL(key: imageKey);
    return copyWith(downloadImageURL: imageURL);
  }
}
