import 'package:fpdart/fpdart.dart';
import '../entities/booking_entity.dart';

/// Repository interface for booking operations
/// This defines the contract that data layer must implement
abstract class BookingRepository {
  /// Create a new booking
  /// Returns Either<String, BookingEntity>
  /// Left: Error message
  /// Right: Created booking with ID
  Future<Either<String, BookingEntity>> createBooking(BookingEntity booking);

  /// Get all bookings
  /// Returns Either<String, List<BookingEntity>>
  /// Left: Error message
  /// Right: List of bookings
  Future<Either<String, List<BookingEntity>>> getBookings();

  /// Get a booking by ID
  /// Returns Either<String, BookingEntity>
  /// Left: Error message
  /// Right: Booking entity
  Future<Either<String, BookingEntity>> getBookingById(String id);

  /// Update booking status (picked up)
  /// Returns Either<String, BookingEntity>
  /// Left: Error message
  /// Right: Updated booking
  Future<Either<String, BookingEntity>> updateBookingStatus(
    String id,
    bool isPickedUp,
  );

  /// Get my bookings by deviceId
  /// Returns Either<String, List<BookingEntity>>
  /// Left: Error message
  /// Right: List of user's bookings
  Future<Either<String, List<BookingEntity>>> getMyBookings(String deviceId);
}
