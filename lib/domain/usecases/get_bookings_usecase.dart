import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../entities/booking_entity.dart';
import '../repositories/booking_repository.dart';

/// Use case for getting all bookings
@injectable
class GetBookingsUseCase {
  final BookingRepository _repository;

  GetBookingsUseCase(this._repository);

  /// Execute the use case
  /// Returns all bookings from the repository
  Future<Either<String, List<BookingEntity>>> call() async {
    return await _repository.getBookings();
  }
}
