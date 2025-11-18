// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BookingModel _$BookingModelFromJson(Map<String, dynamic> json) {
  return _BookingModel.fromJson(json);
}

/// @nodoc
mixin _$BookingModel {
  String? get id => throw _privateConstructorUsedError;
  String get fullName => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;
  String get pickupLocation => throw _privateConstructorUsedError;
  String get dropoffLocation => throw _privateConstructorUsedError;
  int get numberOfBags => throw _privateConstructorUsedError;
  bool get isPickedUp => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this BookingModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BookingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookingModelCopyWith<BookingModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookingModelCopyWith<$Res> {
  factory $BookingModelCopyWith(
          BookingModel value, $Res Function(BookingModel) then) =
      _$BookingModelCopyWithImpl<$Res, BookingModel>;
  @useResult
  $Res call(
      {String? id,
      String fullName,
      String phoneNumber,
      String pickupLocation,
      String dropoffLocation,
      int numberOfBags,
      bool isPickedUp,
      DateTime? createdAt});
}

/// @nodoc
class _$BookingModelCopyWithImpl<$Res, $Val extends BookingModel>
    implements $BookingModelCopyWith<$Res> {
  _$BookingModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BookingModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? fullName = null,
    Object? phoneNumber = null,
    Object? pickupLocation = null,
    Object? dropoffLocation = null,
    Object? numberOfBags = null,
    Object? isPickedUp = null,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      pickupLocation: null == pickupLocation
          ? _value.pickupLocation
          : pickupLocation // ignore: cast_nullable_to_non_nullable
              as String,
      dropoffLocation: null == dropoffLocation
          ? _value.dropoffLocation
          : dropoffLocation // ignore: cast_nullable_to_non_nullable
              as String,
      numberOfBags: null == numberOfBags
          ? _value.numberOfBags
          : numberOfBags // ignore: cast_nullable_to_non_nullable
              as int,
      isPickedUp: null == isPickedUp
          ? _value.isPickedUp
          : isPickedUp // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BookingModelImplCopyWith<$Res>
    implements $BookingModelCopyWith<$Res> {
  factory _$$BookingModelImplCopyWith(
          _$BookingModelImpl value, $Res Function(_$BookingModelImpl) then) =
      __$$BookingModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String fullName,
      String phoneNumber,
      String pickupLocation,
      String dropoffLocation,
      int numberOfBags,
      bool isPickedUp,
      DateTime? createdAt});
}

/// @nodoc
class __$$BookingModelImplCopyWithImpl<$Res>
    extends _$BookingModelCopyWithImpl<$Res, _$BookingModelImpl>
    implements _$$BookingModelImplCopyWith<$Res> {
  __$$BookingModelImplCopyWithImpl(
      _$BookingModelImpl _value, $Res Function(_$BookingModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of BookingModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? fullName = null,
    Object? phoneNumber = null,
    Object? pickupLocation = null,
    Object? dropoffLocation = null,
    Object? numberOfBags = null,
    Object? isPickedUp = null,
    Object? createdAt = freezed,
  }) {
    return _then(_$BookingModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      pickupLocation: null == pickupLocation
          ? _value.pickupLocation
          : pickupLocation // ignore: cast_nullable_to_non_nullable
              as String,
      dropoffLocation: null == dropoffLocation
          ? _value.dropoffLocation
          : dropoffLocation // ignore: cast_nullable_to_non_nullable
              as String,
      numberOfBags: null == numberOfBags
          ? _value.numberOfBags
          : numberOfBags // ignore: cast_nullable_to_non_nullable
              as int,
      isPickedUp: null == isPickedUp
          ? _value.isPickedUp
          : isPickedUp // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BookingModelImpl extends _BookingModel {
  const _$BookingModelImpl(
      {this.id,
      required this.fullName,
      required this.phoneNumber,
      required this.pickupLocation,
      required this.dropoffLocation,
      required this.numberOfBags,
      this.isPickedUp = false,
      this.createdAt})
      : super._();

  factory _$BookingModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BookingModelImplFromJson(json);

  @override
  final String? id;
  @override
  final String fullName;
  @override
  final String phoneNumber;
  @override
  final String pickupLocation;
  @override
  final String dropoffLocation;
  @override
  final int numberOfBags;
  @override
  @JsonKey()
  final bool isPickedUp;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'BookingModel(id: $id, fullName: $fullName, phoneNumber: $phoneNumber, pickupLocation: $pickupLocation, dropoffLocation: $dropoffLocation, numberOfBags: $numberOfBags, isPickedUp: $isPickedUp, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookingModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.pickupLocation, pickupLocation) ||
                other.pickupLocation == pickupLocation) &&
            (identical(other.dropoffLocation, dropoffLocation) ||
                other.dropoffLocation == dropoffLocation) &&
            (identical(other.numberOfBags, numberOfBags) ||
                other.numberOfBags == numberOfBags) &&
            (identical(other.isPickedUp, isPickedUp) ||
                other.isPickedUp == isPickedUp) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, fullName, phoneNumber,
      pickupLocation, dropoffLocation, numberOfBags, isPickedUp, createdAt);

  /// Create a copy of BookingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookingModelImplCopyWith<_$BookingModelImpl> get copyWith =>
      __$$BookingModelImplCopyWithImpl<_$BookingModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BookingModelImplToJson(
      this,
    );
  }
}

abstract class _BookingModel extends BookingModel {
  const factory _BookingModel(
      {final String? id,
      required final String fullName,
      required final String phoneNumber,
      required final String pickupLocation,
      required final String dropoffLocation,
      required final int numberOfBags,
      final bool isPickedUp,
      final DateTime? createdAt}) = _$BookingModelImpl;
  const _BookingModel._() : super._();

  factory _BookingModel.fromJson(Map<String, dynamic> json) =
      _$BookingModelImpl.fromJson;

  @override
  String? get id;
  @override
  String get fullName;
  @override
  String get phoneNumber;
  @override
  String get pickupLocation;
  @override
  String get dropoffLocation;
  @override
  int get numberOfBags;
  @override
  bool get isPickedUp;
  @override
  DateTime? get createdAt;

  /// Create a copy of BookingModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookingModelImplCopyWith<_$BookingModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
