import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_charity_app/api/ser_manos_storage.dart';
import 'package:mobile_charity_app/models/availability.dart';
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
    required int maxVacancies,
    @TimestampConverter() required DateTime createdAt,
    required List<String> volunteersIds,
    required List<String> participantsIds,
    @GeoPointConverter() required GeoPoint location,
    @JsonKey(ignore: true) String? downloadImageURL,
  }) = _VolunteeringModel;

  factory VolunteeringModel.fromJson(Map<String, dynamic> json) =>
      _$VolunteeringModelFromJson(json);

  const VolunteeringModel._();

  Future<VolunteeringModel> fetchDownloadImageURL() async {
    final String imageURL = await SerManosStorage().getDownloadURL(key: imageKey);
    return copyWith(downloadImageURL: imageURL);
  }

  bool userIsParticipant(String userId) => participantsIds.contains(userId);

  int get vacancies => maxVacancies - participantsIds.length;
}
