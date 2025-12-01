import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../entities/booking_entity.dart';
import '../repositories/booking_repository.dart';

/// Use case for getting bookings by deviceId
/// Returns a list of bookings for a specific device
@lazySingleton
class GetMyBookingsUseCase {
  final BookingRepository _repository;

  GetMyBookingsUseCase(this._repository);

  /// Execute the use case
  /// Returns Either<String, List<BookingEntity>>
  /// Left: Error message
  /// Right: List of bookings for the device
  Future<Either<String, List<BookingEntity>>> call(String deviceId) async {
    if (deviceId.isEmpty) {
      return left('Device ID is required');
    }

    return await _repository.getMyBookings(deviceId);
  }
}
