import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/booking_entity.dart';

part 'booking_model.freezed.dart';

/// Data model for Booking with Freezed
/// Handles JSON serialization and Firebase conversion
@freezed
class BookingModel with _$BookingModel {
  const BookingModel._();

  const factory BookingModel({
    String? id,
    required String fullName,
    String? email,
    required String phoneNumber,
    required int numberOfBags,
    dynamic hotelData, // Can be String (ID) or HotelModel object
    String? hotelName, // Optional: Hotel name for display
    String? hotelAddress, // Optional: Hotel address for display
    required String arrivalTime,
    required String deviceId, // Unique device identifier from mobile app
    @Default(false) bool isPickedUp,
    String? status,
    dynamic assignedDriver,
    String? notes,
    dynamic confirmedBy,
    DateTime? confirmedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _BookingModel;

  /// Create from JSON
  factory BookingModel.fromJson(Map<String, dynamic> json) {
    // Handle nested hotel object
    dynamic hotelData = json['hotel'];
    String? hotelName;
    String? hotelAddress;

    if (hotelData is Map<String, dynamic>) {
      // Extract hotel name and address from nested object
      hotelName = hotelData['name'] as String?;
      hotelAddress = hotelData['address'] as String?;
    }

    return BookingModel(
      id: json['id'] as String? ?? json['_id'] as String?,
      fullName: json['fullName'] as String,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String,
      numberOfBags: json['numberOfBags'] as int,
      hotelData: hotelData,
      hotelName: hotelName,
      hotelAddress: hotelAddress,
      arrivalTime: json['arrivalTime'] as String,
      deviceId: json['deviceId'] as String? ?? '',
      isPickedUp: json['isPickedUp'] as bool? ?? false,
      status: json['status'] as String?,
      assignedDriver: json['assignedDriver'],
      notes: json['notes'] as String?,
      confirmedBy: json['confirmedBy'],
      confirmedAt: json['confirmedAt'] != null
          ? DateTime.parse(json['confirmedAt'] as String)
          : null,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }

  /// Create from Firestore DocumentSnapshot
  factory BookingModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return BookingModel(
      id: doc.id,
      fullName: data['fullName'] ?? '',
      email: data['email'],
      phoneNumber: data['phoneNumber'] ?? '',
      numberOfBags: data['numberOfBags'] ?? 1,
      hotelData: data['hotel'] ?? '',
      hotelName: data['hotelName'],
      hotelAddress: data['hotelAddress'],
      arrivalTime: data['arrivalTime'] ?? '',
      deviceId: data['deviceId'] ?? '',
      isPickedUp: data['isPickedUp'] ?? false,
      status: data['status'],
      assignedDriver: data['assignedDriver'],
      notes: data['notes'],
      confirmedBy: data['confirmedBy'],
      confirmedAt: data['confirmedAt'] != null
          ? (data['confirmedAt'] as Timestamp).toDate()
          : null,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate(),
    );
  }

  /// Convert to Firestore Map (without id)
  Map<String, dynamic> toFirestore() {
    final map = {
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'numberOfBags': numberOfBags,
      'hotel': hotelData,
      'arrivalTime': arrivalTime,
      'deviceId': deviceId,
      'isPickedUp': isPickedUp,
      'createdAt': createdAt != null
          ? Timestamp.fromDate(createdAt!)
          : FieldValue.serverTimestamp(),
    };
    if (email != null) {
      map['email'] = email!;
    }
    if (hotelName != null) {
      map['hotelName'] = hotelName!;
    }
    if (hotelAddress != null) {
      map['hotelAddress'] = hotelAddress!;
    }
    if (status != null) {
      map['status'] = status!;
    }
    if (notes != null) {
      map['notes'] = notes!;
    }
    return map;
  }

  /// Convert to domain entity
  BookingEntity toEntity() {
    // Extract hotel ID for entity
    String hotelId;
    if (hotelData is Map<String, dynamic>) {
      hotelId = hotelData['_id'] as String? ?? hotelData['id'] as String? ?? '';
    } else {
      hotelId = hotelData?.toString() ?? '';
    }

    return BookingEntity(
      id: id,
      fullName: fullName,
      email: email,
      phoneNumber: phoneNumber,
      numberOfBags: numberOfBags,
      hotel: hotelId,
      hotelName: hotelName,
      hotelAddress: hotelAddress,
      arrivalTime: arrivalTime,
      deviceId: deviceId,
      isPickedUp: isPickedUp,
      status: status,
      createdAt: createdAt,
    );
  }

  /// Create from domain entity
  factory BookingModel.fromEntity(BookingEntity entity) {
    return BookingModel(
      id: entity.id,
      fullName: entity.fullName,
      email: entity.email,
      phoneNumber: entity.phoneNumber,
      numberOfBags: entity.numberOfBags,
      hotelData: entity.hotel,
      hotelName: entity.hotelName,
      hotelAddress: entity.hotelAddress,
      arrivalTime: entity.arrivalTime,
      deviceId: entity.deviceId,
      isPickedUp: entity.isPickedUp,
      status: entity.status,
      createdAt: entity.createdAt,
    );
  }
}
