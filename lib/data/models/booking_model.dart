import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/booking_entity.dart';

part 'booking_model.freezed.dart';
part 'booking_model.g.dart';

/// Data model for Booking with Freezed
/// Handles JSON serialization and Firebase conversion
@freezed
class BookingModel with _$BookingModel {
  const BookingModel._();

  const factory BookingModel({
    String? id,
    required String fullName,
    required String phoneNumber,
    required String pickupLocation,
    required String dropoffLocation,
    required int numberOfBags,
    @Default(false) bool isPickedUp,
    DateTime? createdAt,
  }) = _BookingModel;

  /// Create from JSON
  factory BookingModel.fromJson(Map<String, dynamic> json) =>
      _$BookingModelFromJson(json);

  /// Create from Firestore DocumentSnapshot
  factory BookingModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return BookingModel(
      id: doc.id,
      fullName: data['fullName'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      pickupLocation: data['pickupLocation'] ?? '',
      dropoffLocation: data['dropoffLocation'] ?? '',
      numberOfBags: data['numberOfBags'] ?? 1,
      isPickedUp: data['isPickedUp'] ?? false,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
    );
  }

  /// Convert to Firestore Map (without id)
  Map<String, dynamic> toFirestore() {
    return {
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'pickupLocation': pickupLocation,
      'dropoffLocation': dropoffLocation,
      'numberOfBags': numberOfBags,
      'isPickedUp': isPickedUp,
      'createdAt': createdAt != null
          ? Timestamp.fromDate(createdAt!)
          : FieldValue.serverTimestamp(),
    };
  }

  /// Convert to domain entity
  BookingEntity toEntity() {
    return BookingEntity(
      id: id,
      fullName: fullName,
      phoneNumber: phoneNumber,
      pickupLocation: pickupLocation,
      dropoffLocation: dropoffLocation,
      numberOfBags: numberOfBags,
      isPickedUp: isPickedUp,
      createdAt: createdAt,
    );
  }

  /// Create from domain entity
  factory BookingModel.fromEntity(BookingEntity entity) {
    return BookingModel(
      id: entity.id,
      fullName: entity.fullName,
      phoneNumber: entity.phoneNumber,
      pickupLocation: entity.pickupLocation,
      dropoffLocation: entity.dropoffLocation,
      numberOfBags: entity.numberOfBags,
      isPickedUp: entity.isPickedUp,
      createdAt: entity.createdAt,
    );
  }
}
