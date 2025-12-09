/// Domain entity for Location
/// Represents a pickup/dropoff location
class LocationEntity {
  final String address;
  final String? name; // Location name (e.g., "Airport", "Hotel Name")

  const LocationEntity({
    required this.address,
    this.name,
  });

  /// Get Google Maps URL for navigation
  String get mapsUrl {
    final encodedAddress = Uri.encodeComponent(address);
    return 'https://www.google.com/maps/search/?api=1&query=$encodedAddress';
  }

  /// Get Apple Maps URL for navigation
  String get appleMapsUrl {
    final encodedAddress = Uri.encodeComponent(address);
    return 'http://maps.apple.com/?q=$encodedAddress';
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'name': name,
    };
  }

  /// Create from JSON
  factory LocationEntity.fromJson(Map<String, dynamic> json) {
    return LocationEntity(
      address: json['address'] as String,
      name: json['name'] as String?,
    );
  }

  /// Create a copy with modified fields
  LocationEntity copyWith({
    String? address,
    String? name,
  }) {
    return LocationEntity(
      address: address ?? this.address,
      name: name ?? this.name,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LocationEntity &&
        other.address == address &&
        other.name == name;
  }

  @override
  int get hashCode {
    return address.hashCode ^ (name?.hashCode ?? 0);
  }

  @override
  String toString() {
    return 'LocationEntity(address: $address, name: $name)';
  }
}
