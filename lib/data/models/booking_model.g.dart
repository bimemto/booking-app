// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BookingModelImpl _$$BookingModelImplFromJson(Map<String, dynamic> json) =>
    _$BookingModelImpl(
      id: json['id'] as String?,
      fullName: json['fullName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      pickupLocation: json['pickupLocation'] as String,
      dropoffLocation: json['dropoffLocation'] as String,
      numberOfBags: (json['numberOfBags'] as num).toInt(),
      isPickedUp: json['isPickedUp'] as bool? ?? false,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$BookingModelImplToJson(_$BookingModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'phoneNumber': instance.phoneNumber,
      'pickupLocation': instance.pickupLocation,
      'dropoffLocation': instance.dropoffLocation,
      'numberOfBags': instance.numberOfBags,
      'isPickedUp': instance.isPickedUp,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
