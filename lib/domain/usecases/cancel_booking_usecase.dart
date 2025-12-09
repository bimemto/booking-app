import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../entities/booking_entity.dart';
import '../repositories/booking_repository.dart';

/// Use case for cancelling a booking
/// Only allowed for bookings with status 'pending' (not yet confirmed by admin)
@injectable
class CancelBookingUseCase {
  final BookingRepository _repository;

  CancelBookingUseCase(this._repository);

  /// Execute the cancel booking use case
  /// Returns Either<String, BookingEntity>
  /// Left: Error message
  /// Right: Cancelled booking entity
  Future<Either<String, BookingEntity>> call(String bookingId) async {
    if (bookingId.isEmpty) {
      return left('Booking ID cannot be empty');
    }

    return await _repository.cancelBooking(bookingId);
  }
}
