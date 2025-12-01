/// Domain entity for Hotel
/// This represents a hotel in the domain layer
class HotelEntity {
  final String id;
  final String name;
  final String address;
  final String zone;

  const HotelEntity({
    required this.id,
    required this.name,
    required this.address,
    required this.zone,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HotelEntity &&
        other.id == id &&
        other.name == name &&
        other.address == address &&
        other.zone == zone;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ address.hashCode ^ zone.hashCode;
  }

  @override
  String toString() {
    return 'HotelEntity(id: $id, name: $name, address: $address, zone: $zone)';
  }
}
