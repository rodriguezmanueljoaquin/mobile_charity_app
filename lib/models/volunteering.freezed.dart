// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'volunteering.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

VolunteeringModel _$VolunteeringModelFromJson(Map<String, dynamic> json) {
  return _VolunteeringModel.fromJson(json);
}

/// @nodoc
mixin _$VolunteeringModel {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get imageKey => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String get about => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String get requirements => throw _privateConstructorUsedError;
  List<Availability> get availability => throw _privateConstructorUsedError;
  int get maxVacancies => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  List<String> get volunteersIds => throw _privateConstructorUsedError;
  List<String> get participantsIds => throw _privateConstructorUsedError;
  @GeoPointConverter()
  GeoPoint get location => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  String? get downloadImageURL => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VolunteeringModelCopyWith<VolunteeringModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VolunteeringModelCopyWith<$Res> {
  factory $VolunteeringModelCopyWith(
          VolunteeringModel value, $Res Function(VolunteeringModel) then) =
      _$VolunteeringModelCopyWithImpl<$Res, VolunteeringModel>;
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      String imageKey,
      String category,
      String about,
      String address,
      String requirements,
      List<Availability> availability,
      int maxVacancies,
      @TimestampConverter() DateTime createdAt,
      List<String> volunteersIds,
      List<String> participantsIds,
      @GeoPointConverter() GeoPoint location,
      @JsonKey(ignore: true) String? downloadImageURL});
}

/// @nodoc
class _$VolunteeringModelCopyWithImpl<$Res, $Val extends VolunteeringModel>
    implements $VolunteeringModelCopyWith<$Res> {
  _$VolunteeringModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? imageKey = null,
    Object? category = null,
    Object? about = null,
    Object? address = null,
    Object? requirements = null,
    Object? availability = null,
    Object? maxVacancies = null,
    Object? createdAt = null,
    Object? volunteersIds = null,
    Object? participantsIds = null,
    Object? location = null,
    Object? downloadImageURL = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      imageKey: null == imageKey
          ? _value.imageKey
          : imageKey // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      about: null == about
          ? _value.about
          : about // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      requirements: null == requirements
          ? _value.requirements
          : requirements // ignore: cast_nullable_to_non_nullable
              as String,
      availability: null == availability
          ? _value.availability
          : availability // ignore: cast_nullable_to_non_nullable
              as List<Availability>,
      maxVacancies: null == maxVacancies
          ? _value.maxVacancies
          : maxVacancies // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      volunteersIds: null == volunteersIds
          ? _value.volunteersIds
          : volunteersIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      participantsIds: null == participantsIds
          ? _value.participantsIds
          : participantsIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as GeoPoint,
      downloadImageURL: freezed == downloadImageURL
          ? _value.downloadImageURL
          : downloadImageURL // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_VolunteeringModelCopyWith<$Res>
    implements $VolunteeringModelCopyWith<$Res> {
  factory _$$_VolunteeringModelCopyWith(_$_VolunteeringModel value,
          $Res Function(_$_VolunteeringModel) then) =
      __$$_VolunteeringModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      String imageKey,
      String category,
      String about,
      String address,
      String requirements,
      List<Availability> availability,
      int maxVacancies,
      @TimestampConverter() DateTime createdAt,
      List<String> volunteersIds,
      List<String> participantsIds,
      @GeoPointConverter() GeoPoint location,
      @JsonKey(ignore: true) String? downloadImageURL});
}

/// @nodoc
class __$$_VolunteeringModelCopyWithImpl<$Res>
    extends _$VolunteeringModelCopyWithImpl<$Res, _$_VolunteeringModel>
    implements _$$_VolunteeringModelCopyWith<$Res> {
  __$$_VolunteeringModelCopyWithImpl(
      _$_VolunteeringModel _value, $Res Function(_$_VolunteeringModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? imageKey = null,
    Object? category = null,
    Object? about = null,
    Object? address = null,
    Object? requirements = null,
    Object? availability = null,
    Object? maxVacancies = null,
    Object? createdAt = null,
    Object? volunteersIds = null,
    Object? participantsIds = null,
    Object? location = null,
    Object? downloadImageURL = freezed,
  }) {
    return _then(_$_VolunteeringModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      imageKey: null == imageKey
          ? _value.imageKey
          : imageKey // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      about: null == about
          ? _value.about
          : about // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      requirements: null == requirements
          ? _value.requirements
          : requirements // ignore: cast_nullable_to_non_nullable
              as String,
      availability: null == availability
          ? _value._availability
          : availability // ignore: cast_nullable_to_non_nullable
              as List<Availability>,
      maxVacancies: null == maxVacancies
          ? _value.maxVacancies
          : maxVacancies // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      volunteersIds: null == volunteersIds
          ? _value._volunteersIds
          : volunteersIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      participantsIds: null == participantsIds
          ? _value._participantsIds
          : participantsIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as GeoPoint,
      downloadImageURL: freezed == downloadImageURL
          ? _value.downloadImageURL
          : downloadImageURL // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_VolunteeringModel extends _VolunteeringModel {
  const _$_VolunteeringModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.imageKey,
      required this.category,
      required this.about,
      required this.address,
      required this.requirements,
      required final List<Availability> availability,
      required this.maxVacancies,
      @TimestampConverter() required this.createdAt,
      required final List<String> volunteersIds,
      required final List<String> participantsIds,
      @GeoPointConverter() required this.location,
      @JsonKey(ignore: true) this.downloadImageURL})
      : _availability = availability,
        _volunteersIds = volunteersIds,
        _participantsIds = participantsIds,
        super._();

  factory _$_VolunteeringModel.fromJson(Map<String, dynamic> json) =>
      _$$_VolunteeringModelFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final String imageKey;
  @override
  final String category;
  @override
  final String about;
  @override
  final String address;
  @override
  final String requirements;
  final List<Availability> _availability;
  @override
  List<Availability> get availability {
    if (_availability is EqualUnmodifiableListView) return _availability;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availability);
  }

  @override
  final int maxVacancies;
  @override
  @TimestampConverter()
  final DateTime createdAt;
  final List<String> _volunteersIds;
  @override
  List<String> get volunteersIds {
    if (_volunteersIds is EqualUnmodifiableListView) return _volunteersIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_volunteersIds);
  }

  final List<String> _participantsIds;
  @override
  List<String> get participantsIds {
    if (_participantsIds is EqualUnmodifiableListView) return _participantsIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_participantsIds);
  }

  @override
  @GeoPointConverter()
  final GeoPoint location;
  @override
  @JsonKey(ignore: true)
  final String? downloadImageURL;

  @override
  String toString() {
    return 'VolunteeringModel(id: $id, title: $title, description: $description, imageKey: $imageKey, category: $category, about: $about, address: $address, requirements: $requirements, availability: $availability, maxVacancies: $maxVacancies, createdAt: $createdAt, volunteersIds: $volunteersIds, participantsIds: $participantsIds, location: $location, downloadImageURL: $downloadImageURL)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_VolunteeringModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.imageKey, imageKey) ||
                other.imageKey == imageKey) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.about, about) || other.about == about) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.requirements, requirements) ||
                other.requirements == requirements) &&
            const DeepCollectionEquality()
                .equals(other._availability, _availability) &&
            (identical(other.maxVacancies, maxVacancies) ||
                other.maxVacancies == maxVacancies) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality()
                .equals(other._volunteersIds, _volunteersIds) &&
            const DeepCollectionEquality()
                .equals(other._participantsIds, _participantsIds) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.downloadImageURL, downloadImageURL) ||
                other.downloadImageURL == downloadImageURL));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      description,
      imageKey,
      category,
      about,
      address,
      requirements,
      const DeepCollectionEquality().hash(_availability),
      maxVacancies,
      createdAt,
      const DeepCollectionEquality().hash(_volunteersIds),
      const DeepCollectionEquality().hash(_participantsIds),
      location,
      downloadImageURL);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_VolunteeringModelCopyWith<_$_VolunteeringModel> get copyWith =>
      __$$_VolunteeringModelCopyWithImpl<_$_VolunteeringModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_VolunteeringModelToJson(
      this,
    );
  }
}

abstract class _VolunteeringModel extends VolunteeringModel {
  const factory _VolunteeringModel(
          {required final String id,
          required final String title,
          required final String description,
          required final String imageKey,
          required final String category,
          required final String about,
          required final String address,
          required final String requirements,
          required final List<Availability> availability,
          required final int maxVacancies,
          @TimestampConverter() required final DateTime createdAt,
          required final List<String> volunteersIds,
          required final List<String> participantsIds,
          @GeoPointConverter() required final GeoPoint location,
          @JsonKey(ignore: true) final String? downloadImageURL}) =
      _$_VolunteeringModel;
  const _VolunteeringModel._() : super._();

  factory _VolunteeringModel.fromJson(Map<String, dynamic> json) =
      _$_VolunteeringModel.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  String get imageKey;
  @override
  String get category;
  @override
  String get about;
  @override
  String get address;
  @override
  String get requirements;
  @override
  List<Availability> get availability;
  @override
  int get maxVacancies;
  @override
  @TimestampConverter()
  DateTime get createdAt;
  @override
  List<String> get volunteersIds;
  @override
  List<String> get participantsIds;
  @override
  @GeoPointConverter()
  GeoPoint get location;
  @override
  @JsonKey(ignore: true)
  String? get downloadImageURL;
  @override
  @JsonKey(ignore: true)
  _$$_VolunteeringModelCopyWith<_$_VolunteeringModel> get copyWith =>
      throw _privateConstructorUsedError;
}
