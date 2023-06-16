import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp json) {
    print('TimestampConverter.fromJson: $json');
    return json.toDate();
  }

  @override
  Timestamp toJson(DateTime object) {
    print('TimestampConverter.toJson: $object');
    return Timestamp.fromDate(object);
  }
}