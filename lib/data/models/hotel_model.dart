import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/hotel_entity.dart';

part 'hotel_model.freezed.dart';
part 'hotel_model.g.dart';

/// Data model for Hotel with Freezed
/// Handles JSON serialization from API
@freezed
class HotelModel with _$HotelModel {
  const HotelModel._();

  const factory HotelModel({
    @JsonKey(name: '_id') required String id,
    required String name,
    required String address,
    required String zone,
  }) = _HotelModel;

  /// Create from JSON
  factory HotelModel.fromJson(Map<String, dynamic> json) =>
      _$HotelModelFromJson(json);

  /// Convert to domain entity
  HotelEntity toEntity() {
    return HotelEntity(
      id: id,
      name: name,
      address: address,
      zone: zone,
    );
  }
}
