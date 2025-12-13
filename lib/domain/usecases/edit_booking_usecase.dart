import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../entities/booking_entity.dart';
import '../repositories/booking_repository.dart';

/// Use case for editing a booking
/// Only allowed for bookings with status 'pending' (not yet confirmed by admin)
@injectable
class EditBookingUseCase {
  final BookingRepository _repository;

  EditBookingUseCase(this._repository);

  /// Execute the edit booking use case
  /// Returns Either<String, BookingEntity>
  /// Left: Error message
  /// Right: Updated booking entity
  Future<Either<String, BookingEntity>> call(
    String bookingId,
    BookingEntity booking,
  ) async {
    if (bookingId.isEmpty) {
      return left('Booking ID cannot be empty');
    }

    return await _repository.editBooking(bookingId, booking);
  }
}
