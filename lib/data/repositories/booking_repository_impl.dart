import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/booking_entity.dart';
import '../../domain/repositories/booking_repository.dart';
import '../datasources/firebase_datasource.dart';
import '../models/booking_model.dart';

/// Implementation of BookingRepository
/// Handles data operations and error handling
/// DISABLED: Firebase requires billing to be enabled
// @LazySingleton(as: BookingRepository)
class BookingRepositoryImpl implements BookingRepository {
  final FirebaseDatasource _datasource;

  BookingRepositoryImpl(this._datasource);

  @override
  Future<Either<String, BookingEntity>> createBooking(
      BookingEntity booking) async {
    try {
      // Convert entity to model
      final model = BookingModel.fromEntity(booking);

      // Create in Firebase
      final createdModel = await _datasource.createBooking(model);

      // Convert back to entity
      return right(createdModel.toEntity());
    } catch (e) {
      return left('Failed to create booking: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, List<BookingEntity>>> getBookings() async {
    try {
      final models = await _datasource.getBookings();
      final entities = models.map((model) => model.toEntity()).toList();
      return right(entities);
    } catch (e) {
      return left('Failed to get bookings: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, BookingEntity>> getBookingById(String id) async {
    try {
      final model = await _datasource.getBookingById(id);
      return right(model.toEntity());
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
      final model = await _datasource.updateBookingStatus(id, isPickedUp);
      return right(model.toEntity());
    } catch (e) {
      return left('Failed to update booking status: ${e.toString()}');
    }
  }
}
