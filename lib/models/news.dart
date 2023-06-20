import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_charity_app/utils/firestore.dart';
import 'package:mobile_charity_app/utils/timestamp_converter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
part 'news.freezed.dart';
part 'news.g.dart';

@freezed
class NewsModel with _$NewsModel {
  const factory NewsModel({
    required String id,
    required String title,
    required String description,
    required String summary,
    required String imageKey,
    required String source,
    @TimestampConverter() required DateTime createdAt,
    @JsonKey(ignore: true) String? downloadImageURL,
  }) = _NewsModel;

  factory NewsModel.fromJson(Map<String, dynamic> json) =>
      _$NewsModelFromJson(json);

  const NewsModel._();

  Future<NewsModel> fetchDownloadImageURL() async {
    final String imageURL = await getDownloadURL(key: imageKey);
    return copyWith(downloadImageURL: imageURL);
  }
}
