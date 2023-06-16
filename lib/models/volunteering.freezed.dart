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
  String get imageURL => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String get about => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  List<String> get requirements => throw _privateConstructorUsedError;
  List<Availability> get availability => throw _privateConstructorUsedError;
  int get vacancies => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  List<String> get volunteerIds => throw _privateConstructorUsedError;

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
      String imageURL,
      String category,
      String about,
      String address,
      List<String> requirements,
      List<Availability> availability,
      int vacancies,
      @TimestampConverter() DateTime createdAt,
      List<String> volunteerIds});
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
    Object? imageURL = null,
    Object? category = null,
    Object? about = null,
    Object? address = null,
    Object? requirements = null,
    Object? availability = null,
    Object? vacancies = null,
    Object? createdAt = null,
    Object? volunteerIds = null,
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
      imageURL: null == imageURL
          ? _value.imageURL
          : imageURL // ignore: cast_nullable_to_non_nullable
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
              as List<String>,
      availability: null == availability
          ? _value.availability
          : availability // ignore: cast_nullable_to_non_nullable
              as List<Availability>,
      vacancies: null == vacancies
          ? _value.vacancies
          : vacancies // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      volunteerIds: null == volunteerIds
          ? _value.volunteerIds
          : volunteerIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
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
      String imageURL,
      String category,
      String about,
      String address,
      List<String> requirements,
      List<Availability> availability,
      int vacancies,
      @TimestampConverter() DateTime createdAt,
      List<String> volunteerIds});
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
    Object? imageURL = null,
    Object? category = null,
    Object? about = null,
    Object? address = null,
    Object? requirements = null,
    Object? availability = null,
    Object? vacancies = null,
    Object? createdAt = null,
    Object? volunteerIds = null,
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
      imageURL: null == imageURL
          ? _value.imageURL
          : imageURL // ignore: cast_nullable_to_non_nullable
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
          ? _value._requirements
          : requirements // ignore: cast_nullable_to_non_nullable
              as List<String>,
      availability: null == availability
          ? _value._availability
          : availability // ignore: cast_nullable_to_non_nullable
              as List<Availability>,
      vacancies: null == vacancies
          ? _value.vacancies
          : vacancies // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      volunteerIds: null == volunteerIds
          ? _value._volunteerIds
          : volunteerIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_VolunteeringModel implements _VolunteeringModel {
  const _$_VolunteeringModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.imageURL,
      required this.category,
      required this.about,
      required this.address,
      required final List<String> requirements,
      required final List<Availability> availability,
      required this.vacancies,
      @TimestampConverter() required this.createdAt,
      required final List<String> volunteerIds})
      : _requirements = requirements,
        _availability = availability,
        _volunteerIds = volunteerIds;

  factory _$_VolunteeringModel.fromJson(Map<String, dynamic> json) =>
      _$$_VolunteeringModelFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final String imageURL;
  @override
  final String category;
  @override
  final String about;
  @override
  final String address;
  final List<String> _requirements;
  @override
  List<String> get requirements {
    if (_requirements is EqualUnmodifiableListView) return _requirements;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_requirements);
  }

  final List<Availability> _availability;
  @override
  List<Availability> get availability {
    if (_availability is EqualUnmodifiableListView) return _availability;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availability);
  }

  @override
  final int vacancies;
  @override
  @TimestampConverter()
  final DateTime createdAt;
  final List<String> _volunteerIds;
  @override
  List<String> get volunteerIds {
    if (_volunteerIds is EqualUnmodifiableListView) return _volunteerIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_volunteerIds);
  }

  @override
  String toString() {
    return 'VolunteeringModel(id: $id, title: $title, description: $description, imageURL: $imageURL, category: $category, about: $about, address: $address, requirements: $requirements, availability: $availability, vacancies: $vacancies, createdAt: $createdAt, volunteerIds: $volunteerIds)';
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
            (identical(other.imageURL, imageURL) ||
                other.imageURL == imageURL) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.about, about) || other.about == about) &&
            (identical(other.address, address) || other.address == address) &&
            const DeepCollectionEquality()
                .equals(other._requirements, _requirements) &&
            const DeepCollectionEquality()
                .equals(other._availability, _availability) &&
            (identical(other.vacancies, vacancies) ||
                other.vacancies == vacancies) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality()
                .equals(other._volunteerIds, _volunteerIds));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      description,
      imageURL,
      category,
      about,
      address,
      const DeepCollectionEquality().hash(_requirements),
      const DeepCollectionEquality().hash(_availability),
      vacancies,
      createdAt,
      const DeepCollectionEquality().hash(_volunteerIds));

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

abstract class _VolunteeringModel implements VolunteeringModel {
  const factory _VolunteeringModel(
      {required final String id,
      required final String title,
      required final String description,
      required final String imageURL,
      required final String category,
      required final String about,
      required final String address,
      required final List<String> requirements,
      required final List<Availability> availability,
      required final int vacancies,
      @TimestampConverter() required final DateTime createdAt,
      required final List<String> volunteerIds}) = _$_VolunteeringModel;

  factory _VolunteeringModel.fromJson(Map<String, dynamic> json) =
      _$_VolunteeringModel.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  String get imageURL;
  @override
  String get category;
  @override
  String get about;
  @override
  String get address;
  @override
  List<String> get requirements;
  @override
  List<Availability> get availability;
  @override
  int get vacancies;
  @override
  @TimestampConverter()
  DateTime get createdAt;
  @override
  List<String> get volunteerIds;
  @override
  @JsonKey(ignore: true)
  _$$_VolunteeringModelCopyWith<_$_VolunteeringModel> get copyWith =>
      throw _privateConstructorUsedError;
}
