import 'package:freezed_annotation/freezed_annotation.dart';

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
    required List<String> availability,
    required int vacancies,
    required DateTime createdAt,
    required List<String> volunteerIds,
  }) = _VolunteeringModel;

  factory VolunteeringModel.fromJson(Map<String, dynamic> json) =>
      _$VolunteeringModelFromJson(json);
}
