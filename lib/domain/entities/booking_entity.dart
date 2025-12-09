/// Domain entity for Booking
/// This represents the core business object in the domain layer
class BookingEntity {
  final String? id;
  final String fullName;
  final String? email;
  final String phoneNumber;
  final int numberOfBags;
  final String hotel; // Hotel ID (ObjectId) for API, or hotel name for display
  final String? hotelName; // Optional: Hotel name for display purposes
  final String? hotelAddress; // Optional: Hotel address for display purposes
  final String? pickupLocation; // Pickup location address
  final String? pickupLocationType; // 'airport' or 'other'
  final String? arrivalTime; // Required if pickupLocationType is 'airport'
  final String deviceId; // Unique device identifier from mobile app
  final bool isPickedUp;
  final String? status; // Booking status: 'pending', 'confirmed', 'picked_up', etc.
  final DateTime? createdAt;

  const BookingEntity({
    this.id,
    required this.fullName,
    this.email,
    required this.phoneNumber,
    required this.numberOfBags,
    required this.hotel,
    this.hotelName,
    this.hotelAddress,
    this.pickupLocation,
    this.pickupLocationType,
    this.arrivalTime,
    required this.deviceId,
    this.isPickedUp = false,
    this.status,
    this.createdAt,
  });

  /// Convert to JSON for QR code (minimal data)
  Map<String, dynamic> toQRJson() {
    return {
      'name': fullName,
      'phone': phoneNumber,
      'email': email ?? '',
      'bags': numberOfBags,
      'hotel': hotelName,
      'hotelAddress': hotelAddress ?? '',
      'pickupLocation': pickupLocation ?? '',
      'pickupType': pickupLocationType ?? '',
      'arrival': arrivalTime ?? '',
    };
  }

  /// Create a copy with modified fields
  BookingEntity copyWith({
    String? id,
    String? fullName,
    String? email,
    String? phoneNumber,
    int? numberOfBags,
    String? hotel,
    String? hotelName,
    String? hotelAddress,
    String? pickupLocation,
    String? pickupLocationType,
    String? arrivalTime,
    String? deviceId,
    bool? isPickedUp,
    String? status,
    DateTime? createdAt,
  }) {
    return BookingEntity(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      numberOfBags: numberOfBags ?? this.numberOfBags,
      hotel: hotel ?? this.hotel,
      hotelName: hotelName ?? this.hotelName,
      hotelAddress: hotelAddress ?? this.hotelAddress,
      pickupLocation: pickupLocation ?? this.pickupLocation,
      pickupLocationType: pickupLocationType ?? this.pickupLocationType,
      arrivalTime: arrivalTime ?? this.arrivalTime,
      deviceId: deviceId ?? this.deviceId,
      isPickedUp: isPickedUp ?? this.isPickedUp,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BookingEntity &&
        other.id == id &&
        other.fullName == fullName &&
        other.email == email &&
        other.phoneNumber == phoneNumber &&
        other.numberOfBags == numberOfBags &&
        other.hotel == hotel &&
        other.hotelName == hotelName &&
        other.hotelAddress == hotelAddress &&
        other.pickupLocation == pickupLocation &&
        other.pickupLocationType == pickupLocationType &&
        other.arrivalTime == arrivalTime &&
        other.deviceId == deviceId &&
        other.isPickedUp == isPickedUp &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        fullName.hashCode ^
        (email?.hashCode ?? 0) ^
        phoneNumber.hashCode ^
        numberOfBags.hashCode ^
        hotel.hashCode ^
        (hotelName?.hashCode ?? 0) ^
        (hotelAddress?.hashCode ?? 0) ^
        (pickupLocation?.hashCode ?? 0) ^
        (pickupLocationType?.hashCode ?? 0) ^
        (arrivalTime?.hashCode ?? 0) ^
        deviceId.hashCode ^
        isPickedUp.hashCode ^
        (status?.hashCode ?? 0);
  }

  @override
  String toString() {
    return 'BookingEntity(id: $id, fullName: $fullName, email: $email, phoneNumber: $phoneNumber, numberOfBags: $numberOfBags, hotel: $hotel, hotelName: $hotelName, hotelAddress: $hotelAddress, pickupLocation: $pickupLocation, pickupLocationType: $pickupLocationType, arrivalTime: $arrivalTime, deviceId: $deviceId, isPickedUp: $isPickedUp, status: $status, createdAt: $createdAt)';
  }

  /// Get the display name for the hotel (use hotelName if available, otherwise hotel ID)
  String get hotelDisplayName => hotelName ?? hotel;

  /// Check if booking is confirmed or assigned (ready to show QR code)
  bool get isConfirmed =>
      status?.toLowerCase() == 'confirmed' ||
      status?.toLowerCase() == 'assigned';
}
