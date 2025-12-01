import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../entities/booking_entity.dart';
import '../repositories/booking_repository.dart';

/// Use case for getting a booking by ID
@injectable
class GetBookingByIdUseCase {
  final BookingRepository _repository;

  GetBookingByIdUseCase(this._repository);

  /// Execute the use case
  /// Returns a booking with the given ID
  Future<Either<String, BookingEntity>> call(String id) async {
    return await _repository.getBookingById(id);
  }
}
