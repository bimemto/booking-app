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

/// @nodoc
mixin _$BookingModel {
  String? get id => throw _privateConstructorUsedError;
  String get fullName => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;
  int get numberOfBags => throw _privateConstructorUsedError;
  dynamic get hotelData =>
      throw _privateConstructorUsedError; // Can be String (ID) or HotelModel object
  String? get hotelName =>
      throw _privateConstructorUsedError; // Optional: Hotel name for display
  String? get hotelAddress =>
      throw _privateConstructorUsedError; // Optional: Hotel address for display
  String get arrivalTime => throw _privateConstructorUsedError;
  String get deviceId =>
      throw _privateConstructorUsedError; // Unique device identifier from mobile app
  bool get isPickedUp => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  dynamic get assignedDriver => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  dynamic get confirmedBy => throw _privateConstructorUsedError;
  DateTime? get confirmedAt => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

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
      String? email,
      String phoneNumber,
      int numberOfBags,
      dynamic hotelData,
      String? hotelName,
      String? hotelAddress,
      String arrivalTime,
      String deviceId,
      bool isPickedUp,
      String? status,
      dynamic assignedDriver,
      String? notes,
      dynamic confirmedBy,
      DateTime? confirmedAt,
      DateTime? createdAt,
      DateTime? updatedAt});
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
    Object? email = freezed,
    Object? phoneNumber = null,
    Object? numberOfBags = null,
    Object? hotelData = freezed,
    Object? hotelName = freezed,
    Object? hotelAddress = freezed,
    Object? arrivalTime = null,
    Object? deviceId = null,
    Object? isPickedUp = null,
    Object? status = freezed,
    Object? assignedDriver = freezed,
    Object? notes = freezed,
    Object? confirmedBy = freezed,
    Object? confirmedAt = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
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
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      numberOfBags: null == numberOfBags
          ? _value.numberOfBags
          : numberOfBags // ignore: cast_nullable_to_non_nullable
              as int,
      hotelData: freezed == hotelData
          ? _value.hotelData
          : hotelData // ignore: cast_nullable_to_non_nullable
              as dynamic,
      hotelName: freezed == hotelName
          ? _value.hotelName
          : hotelName // ignore: cast_nullable_to_non_nullable
              as String?,
      hotelAddress: freezed == hotelAddress
          ? _value.hotelAddress
          : hotelAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      arrivalTime: null == arrivalTime
          ? _value.arrivalTime
          : arrivalTime // ignore: cast_nullable_to_non_nullable
              as String,
      deviceId: null == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String,
      isPickedUp: null == isPickedUp
          ? _value.isPickedUp
          : isPickedUp // ignore: cast_nullable_to_non_nullable
              as bool,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      assignedDriver: freezed == assignedDriver
          ? _value.assignedDriver
          : assignedDriver // ignore: cast_nullable_to_non_nullable
              as dynamic,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      confirmedBy: freezed == confirmedBy
          ? _value.confirmedBy
          : confirmedBy // ignore: cast_nullable_to_non_nullable
              as dynamic,
      confirmedAt: freezed == confirmedAt
          ? _value.confirmedAt
          : confirmedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
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
      String? email,
      String phoneNumber,
      int numberOfBags,
      dynamic hotelData,
      String? hotelName,
      String? hotelAddress,
      String arrivalTime,
      String deviceId,
      bool isPickedUp,
      String? status,
      dynamic assignedDriver,
      String? notes,
      dynamic confirmedBy,
      DateTime? confirmedAt,
      DateTime? createdAt,
      DateTime? updatedAt});
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
    Object? email = freezed,
    Object? phoneNumber = null,
    Object? numberOfBags = null,
    Object? hotelData = freezed,
    Object? hotelName = freezed,
    Object? hotelAddress = freezed,
    Object? arrivalTime = null,
    Object? deviceId = null,
    Object? isPickedUp = null,
    Object? status = freezed,
    Object? assignedDriver = freezed,
    Object? notes = freezed,
    Object? confirmedBy = freezed,
    Object? confirmedAt = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
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
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      numberOfBags: null == numberOfBags
          ? _value.numberOfBags
          : numberOfBags // ignore: cast_nullable_to_non_nullable
              as int,
      hotelData: freezed == hotelData
          ? _value.hotelData
          : hotelData // ignore: cast_nullable_to_non_nullable
              as dynamic,
      hotelName: freezed == hotelName
          ? _value.hotelName
          : hotelName // ignore: cast_nullable_to_non_nullable
              as String?,
      hotelAddress: freezed == hotelAddress
          ? _value.hotelAddress
          : hotelAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      arrivalTime: null == arrivalTime
          ? _value.arrivalTime
          : arrivalTime // ignore: cast_nullable_to_non_nullable
              as String,
      deviceId: null == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String,
      isPickedUp: null == isPickedUp
          ? _value.isPickedUp
          : isPickedUp // ignore: cast_nullable_to_non_nullable
              as bool,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      assignedDriver: freezed == assignedDriver
          ? _value.assignedDriver
          : assignedDriver // ignore: cast_nullable_to_non_nullable
              as dynamic,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      confirmedBy: freezed == confirmedBy
          ? _value.confirmedBy
          : confirmedBy // ignore: cast_nullable_to_non_nullable
              as dynamic,
      confirmedAt: freezed == confirmedAt
          ? _value.confirmedAt
          : confirmedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$BookingModelImpl extends _BookingModel {
  const _$BookingModelImpl(
      {this.id,
      required this.fullName,
      this.email,
      required this.phoneNumber,
      required this.numberOfBags,
      this.hotelData,
      this.hotelName,
      this.hotelAddress,
      required this.arrivalTime,
      required this.deviceId,
      this.isPickedUp = false,
      this.status,
      this.assignedDriver,
      this.notes,
      this.confirmedBy,
      this.confirmedAt,
      this.createdAt,
      this.updatedAt})
      : super._();

  @override
  final String? id;
  @override
  final String fullName;
  @override
  final String? email;
  @override
  final String phoneNumber;
  @override
  final int numberOfBags;
  @override
  final dynamic hotelData;
// Can be String (ID) or HotelModel object
  @override
  final String? hotelName;
// Optional: Hotel name for display
  @override
  final String? hotelAddress;
// Optional: Hotel address for display
  @override
  final String arrivalTime;
  @override
  final String deviceId;
// Unique device identifier from mobile app
  @override
  @JsonKey()
  final bool isPickedUp;
  @override
  final String? status;
  @override
  final dynamic assignedDriver;
  @override
  final String? notes;
  @override
  final dynamic confirmedBy;
  @override
  final DateTime? confirmedAt;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'BookingModel(id: $id, fullName: $fullName, email: $email, phoneNumber: $phoneNumber, numberOfBags: $numberOfBags, hotelData: $hotelData, hotelName: $hotelName, hotelAddress: $hotelAddress, arrivalTime: $arrivalTime, deviceId: $deviceId, isPickedUp: $isPickedUp, status: $status, assignedDriver: $assignedDriver, notes: $notes, confirmedBy: $confirmedBy, confirmedAt: $confirmedAt, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookingModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.numberOfBags, numberOfBags) ||
                other.numberOfBags == numberOfBags) &&
            const DeepCollectionEquality().equals(other.hotelData, hotelData) &&
            (identical(other.hotelName, hotelName) ||
                other.hotelName == hotelName) &&
            (identical(other.hotelAddress, hotelAddress) ||
                other.hotelAddress == hotelAddress) &&
            (identical(other.arrivalTime, arrivalTime) ||
                other.arrivalTime == arrivalTime) &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId) &&
            (identical(other.isPickedUp, isPickedUp) ||
                other.isPickedUp == isPickedUp) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality()
                .equals(other.assignedDriver, assignedDriver) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            const DeepCollectionEquality()
                .equals(other.confirmedBy, confirmedBy) &&
            (identical(other.confirmedAt, confirmedAt) ||
                other.confirmedAt == confirmedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      fullName,
      email,
      phoneNumber,
      numberOfBags,
      const DeepCollectionEquality().hash(hotelData),
      hotelName,
      hotelAddress,
      arrivalTime,
      deviceId,
      isPickedUp,
      status,
      const DeepCollectionEquality().hash(assignedDriver),
      notes,
      const DeepCollectionEquality().hash(confirmedBy),
      confirmedAt,
      createdAt,
      updatedAt);

  /// Create a copy of BookingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookingModelImplCopyWith<_$BookingModelImpl> get copyWith =>
      __$$BookingModelImplCopyWithImpl<_$BookingModelImpl>(this, _$identity);
}

abstract class _BookingModel extends BookingModel {
  const factory _BookingModel(
      {final String? id,
      required final String fullName,
      final String? email,
      required final String phoneNumber,
      required final int numberOfBags,
      final dynamic hotelData,
      final String? hotelName,
      final String? hotelAddress,
      required final String arrivalTime,
      required final String deviceId,
      final bool isPickedUp,
      final String? status,
      final dynamic assignedDriver,
      final String? notes,
      final dynamic confirmedBy,
      final DateTime? confirmedAt,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$BookingModelImpl;
  const _BookingModel._() : super._();

  @override
  String? get id;
  @override
  String get fullName;
  @override
  String? get email;
  @override
  String get phoneNumber;
  @override
  int get numberOfBags;
  @override
  dynamic get hotelData; // Can be String (ID) or HotelModel object
  @override
  String? get hotelName; // Optional: Hotel name for display
  @override
  String? get hotelAddress; // Optional: Hotel address for display
  @override
  String get arrivalTime;
  @override
  String get deviceId; // Unique device identifier from mobile app
  @override
  bool get isPickedUp;
  @override
  String? get status;
  @override
  dynamic get assignedDriver;
  @override
  String? get notes;
  @override
  dynamic get confirmedBy;
  @override
  DateTime? get confirmedAt;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of BookingModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookingModelImplCopyWith<_$BookingModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
