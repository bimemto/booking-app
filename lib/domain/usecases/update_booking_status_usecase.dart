import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../entities/booking_entity.dart';
import '../repositories/booking_repository.dart';

/// Use case for updating booking status
@injectable
class UpdateBookingStatusUseCase {
  final BookingRepository _repository;

  UpdateBookingStatusUseCase(this._repository);

  /// Execute the use case
  /// Updates the pickup status of a booking
  Future<Either<String, BookingEntity>> call(String id, bool isPickedUp) async {
    if (id.isEmpty) {
      return left('Booking ID is required');
    }

    return await _repository.updateBookingStatus(id, isPickedUp);
  }
}
