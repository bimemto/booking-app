/// Domain entity for Booking
/// This represents the core business object in the domain layer
class BookingEntity {
  final String? id;
  final String fullName;
  final String phoneNumber;
  final String pickupLocation;
  final String dropoffLocation;
  final int numberOfBags;
  final bool isPickedUp;
  final DateTime? createdAt;

  const BookingEntity({
    this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.pickupLocation,
    required this.dropoffLocation,
    required this.numberOfBags,
    this.isPickedUp = false,
    this.createdAt,
  });

  /// Convert to JSON for QR code (minimal data)
  Map<String, dynamic> toQRJson() {
    return {
      'name': fullName,
      'phone': phoneNumber,
      'bags': numberOfBags,
    };
  }

  /// Create a copy with modified fields
  BookingEntity copyWith({
    String? id,
    String? fullName,
    String? phoneNumber,
    String? pickupLocation,
    String? dropoffLocation,
    int? numberOfBags,
    bool? isPickedUp,
    DateTime? createdAt,
  }) {
    return BookingEntity(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      pickupLocation: pickupLocation ?? this.pickupLocation,
      dropoffLocation: dropoffLocation ?? this.dropoffLocation,
      numberOfBags: numberOfBags ?? this.numberOfBags,
      isPickedUp: isPickedUp ?? this.isPickedUp,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BookingEntity &&
        other.id == id &&
        other.fullName == fullName &&
        other.phoneNumber == phoneNumber &&
        other.pickupLocation == pickupLocation &&
        other.dropoffLocation == dropoffLocation &&
        other.numberOfBags == numberOfBags &&
        other.isPickedUp == isPickedUp;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        fullName.hashCode ^
        phoneNumber.hashCode ^
        pickupLocation.hashCode ^
        dropoffLocation.hashCode ^
        numberOfBags.hashCode ^
        isPickedUp.hashCode;
  }

  @override
  String toString() {
    return 'BookingEntity(id: $id, fullName: $fullName, phoneNumber: $phoneNumber, pickupLocation: $pickupLocation, dropoffLocation: $dropoffLocation, numberOfBags: $numberOfBags, isPickedUp: $isPickedUp, createdAt: $createdAt)';
  }
}
