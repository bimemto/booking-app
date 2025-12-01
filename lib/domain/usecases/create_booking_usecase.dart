import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../entities/booking_entity.dart';
import '../repositories/booking_repository.dart';

/// Use case for creating a booking
/// Encapsulates business logic for booking creation
@injectable
class CreateBookingUseCase {
  final BookingRepository _repository;

  CreateBookingUseCase(this._repository);

  /// Execute the use case
  /// Validates and creates a booking
  Future<Either<String, BookingEntity>> call(BookingEntity booking) async {
    // Validate booking data
    final validation = _validateBooking(booking);
    if (validation.isLeft()) {
      return validation;
    }

    // Call repository to create booking
    return await _repository.createBooking(booking);
  }

  /// Validate booking data
  Either<String, BookingEntity> _validateBooking(BookingEntity booking) {
    // Validate full name
    if (booking.fullName.trim().isEmpty) {
      return left('Full name is required');
    }

    // Validate phone number (must start with 0 and be 10-11 digits)
    final phoneRegex = RegExp(r'^0\d{9,10}$');
    if (booking.phoneNumber.trim().isEmpty) {
      return left('Phone number is required');
    }
    if (!phoneRegex.hasMatch(booking.phoneNumber)) {
      return left('Invalid phone number format (must start with 0 and be 10-11 digits)');
    }

    // Validate hotel
    if (booking.hotel.trim().isEmpty) {
      return left('Hotel is required');
    }

    // Validate arrival time
    if (booking.arrivalTime.trim().isEmpty) {
      return left('Arrival time is required');
    }

    // Validate number of bags (1-5)
    if (booking.numberOfBags < 1 || booking.numberOfBags > 5) {
      return left('Number of bags must be between 1 and 5');
    }

    return right(booking);
  }
}
