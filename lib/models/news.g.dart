// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_NewsModel _$$_NewsModelFromJson(Map<String, dynamic> json) => _$_NewsModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      summary: json['summary'] as String,
      imageURL: json['imageURL'] as String,
      source: json['source'] as String,
    );

Map<String, dynamic> _$$_NewsModelToJson(_$_NewsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'summary': instance.summary,
      'imageURL': instance.imageURL,
      'source': instance.source,
    };
