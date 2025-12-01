import 'package:fpdart/fpdart.dart';
import '../../domain/entities/booking_entity.dart';
import '../../domain/repositories/booking_repository.dart';

/// Mock implementation of BookingRepository
/// Used for testing without Firebase billing
/// DISABLED: Now using HTTP API backend
// @LazySingleton(as: BookingRepository)
class MockBookingRepositoryImpl implements BookingRepository {
  // In-memory storage for bookings
  final List<BookingEntity> _bookings = [];
  int _idCounter = 1;

  @override
  Future<Either<String, BookingEntity>> createBooking(
      BookingEntity booking) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));

      // Generate a unique ID and timestamp
      final createdBooking = booking.copyWith(
        id: 'BOOK${_idCounter.toString().padLeft(6, '0')}',
        createdAt: DateTime.now(),
      );
      _idCounter++;

      // Store in memory
      _bookings.add(createdBooking);

      return right(createdBooking);
    } catch (e) {
      return left('Failed to create booking: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, List<BookingEntity>>> getBookings() async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 300));

      return right(List.from(_bookings));
    } catch (e) {
      return left('Failed to get bookings: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, BookingEntity>> getBookingById(String id) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 300));

      final booking = _bookings.firstWhere(
        (b) => b.id == id,
        orElse: () => throw Exception('Booking not found'),
      );

      return right(booking);
    } catch (e) {
      return left('Failed to get booking: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, BookingEntity>> updateBookingStatus(
    String id,
    bool isPickedUp,
  ) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));

      final index = _bookings.indexWhere((b) => b.id == id);
      if (index == -1) {
        return left('Booking not found');
      }

      // Update the booking status
      final updatedBooking = _bookings[index].copyWith(
        isPickedUp: isPickedUp,
      );

      _bookings[index] = updatedBooking;

      return right(updatedBooking);
    } catch (e) {
      return left('Failed to update booking status: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, List<BookingEntity>>> getMyBookings(String deviceId) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 300));

      // Filter bookings by deviceId
      final myBookings = _bookings.where((b) => b.deviceId == deviceId).toList();

      return right(myBookings);
    } catch (e) {
      return left('Failed to get my bookings: ${e.toString()}');
    }
  }
}
