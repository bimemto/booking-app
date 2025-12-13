import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:injectable/injectable.dart';
import 'package:signals_flutter/signals_flutter.dart';
import '../../domain/entities/booking_entity.dart';
import '../../domain/usecases/cancel_booking_usecase.dart';
import '../../domain/usecases/create_booking_usecase.dart';
import '../../domain/usecases/edit_booking_usecase.dart';
import '../../domain/usecases/get_booking_by_id_usecase.dart';
import '../../domain/usecases/get_bookings_usecase.dart';
import '../../domain/usecases/update_booking_status_usecase.dart';

/// Provider for booking state management using signals_flutter
@injectable
class BookingProvider {
  final CreateBookingUseCase _createBookingUseCase;
  final GetBookingsUseCase _getBookingsUseCase;
  final GetBookingByIdUseCase _getBookingByIdUseCase;
  final UpdateBookingStatusUseCase _updateBookingStatusUseCase;
  final CancelBookingUseCase _cancelBookingUseCase;
  final EditBookingUseCase _editBookingUseCase;

  BookingProvider(
    this._createBookingUseCase,
    this._getBookingsUseCase,
    this._getBookingByIdUseCase,
    this._updateBookingStatusUseCase,
    this._cancelBookingUseCase,
    this._editBookingUseCase,
  );

  // Signals for reactive state
  final isLoading = signal<bool>(false);
  final bookings = signal<List<BookingEntity>>([]);
  final currentBooking = signal<BookingEntity?>(null);
  final errorMessage = signal<String?>(null);

  /// Create a new booking
  Future<bool> createBooking(BookingEntity booking) async {
    isLoading.value = true;
    errorMessage.value = null;

    final result = await _createBookingUseCase(booking);

    return result.fold(
      (error) {
        isLoading.value = false;
        errorMessage.value = error;
        SmartDialog.showToast(
          error,
          displayType: SmartToastType.last,
        );
        return false;
      },
      (createdBooking) {
        isLoading.value = false;
        currentBooking.value = createdBooking;
        SmartDialog.showToast(
          'Booking created successfully!',
          displayType: SmartToastType.last,
        );
        return true;
      },
    );
  }

  /// Get all bookings
  Future<void> getBookings() async {
    isLoading.value = true;
    errorMessage.value = null;

    final result = await _getBookingsUseCase();

    result.fold(
      (error) {
        isLoading.value = false;
        errorMessage.value = error;
        SmartDialog.showToast(
          error,
          displayType: SmartToastType.last,
        );
      },
      (fetchedBookings) {
        isLoading.value = false;
        bookings.value = fetchedBookings;
      },
    );
  }

  /// Update booking status (mark as picked up)
  Future<void> updateBookingStatus(String id, bool isPickedUp) async {
    isLoading.value = true;
    errorMessage.value = null;

    final result = await _updateBookingStatusUseCase(id, isPickedUp);

    result.fold(
      (error) {
        isLoading.value = false;
        errorMessage.value = error;
        SmartDialog.showToast(
          error,
          displayType: SmartToastType.last,
        );
      },
      (updatedBooking) {
        isLoading.value = false;
        currentBooking.value = updatedBooking;
        SmartDialog.showToast(
          'Booking status updated!',
          displayType: SmartToastType.last,
        );
      },
    );
  }

  /// Refresh/reload a booking by ID (for checking status updates)
  Future<bool> refreshBooking(String id) async {
    isLoading.value = true;
    errorMessage.value = null;

    final result = await _getBookingByIdUseCase(id);

    return result.fold(
      (error) {
        isLoading.value = false;
        errorMessage.value = error;
        SmartDialog.showToast(
          error,
          displayType: SmartToastType.last,
        );
        return false;
      },
      (refreshedBooking) {
        isLoading.value = false;
        currentBooking.value = refreshedBooking;
        return true;
      },
    );
  }

  /// Set current booking (for local state updates)
  void setCurrentBooking(BookingEntity booking) {
    currentBooking.value = booking;
  }

  /// Clear current booking
  void clearCurrentBooking() {
    currentBooking.value = null;
  }

  /// Clear error message
  void clearError() {
    errorMessage.value = null;
  }

  /// Cancel a booking (only allowed for pending status)
  Future<bool> cancelBooking(String id) async {
    isLoading.value = true;
    errorMessage.value = null;

    final result = await _cancelBookingUseCase(id);

    return result.fold(
      (error) {
        isLoading.value = false;
        errorMessage.value = error;
        SmartDialog.showToast(
          error,
          displayType: SmartToastType.last,
        );
        return false;
      },
      (cancelledBooking) {
        isLoading.value = false;
        currentBooking.value = cancelledBooking;
        SmartDialog.showToast(
          'Booking cancelled successfully',
          displayType: SmartToastType.last,
        );
        return true;
      },
    );
  }

  /// Edit a booking (only allowed for pending status)
  Future<bool> editBooking(String id, BookingEntity booking) async {
    isLoading.value = true;
    errorMessage.value = null;

    final result = await _editBookingUseCase(id, booking);

    return result.fold(
      (error) {
        isLoading.value = false;
        errorMessage.value = error;
        SmartDialog.showToast(
          error,
          displayType: SmartToastType.last,
        );
        return false;
      },
      (updatedBooking) {
        isLoading.value = false;
        currentBooking.value = updatedBooking;
        SmartDialog.showToast(
          'Booking updated successfully',
          displayType: SmartToastType.last,
        );
        return true;
      },
    );
  }
}
