import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import '../models/booking_model.dart';

/// HTTP API datasource for booking operations
/// Connects to Node.js Express backend
@LazySingleton()
class HttpApiDatasource {
  late final Dio _dio;
  final String _baseUrl;

  HttpApiDatasource() : _baseUrl = dotenv.env['API_BASE_URL'] ?? 'http://localhost:3001/api' {
    _dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Add logging interceptor
    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (obj) => print('[HTTP] $obj'),
      ),
    );
  }

  /// Create a new booking
  Future<BookingModel> createBooking(BookingModel booking) async {
    try {
      final response = await _dio.post(
        '/booking',
        data: {
          'fullName': booking.fullName,
          'phoneNumber': booking.phoneNumber,
          'pickupLocation': booking.pickupLocation,
          'dropoffLocation': booking.dropoffLocation,
          'numberOfBags': booking.numberOfBags,
        },
      );

      if (response.statusCode == 201 && response.data['success'] == true) {
        final bookingData = response.data['data']['booking'];
        return BookingModel.fromJson(bookingData);
      } else {
        throw Exception('Failed to create booking: ${response.data}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final errors = e.response!.data['errors'];
        throw Exception('Validation error: ${errors.join(', ')}');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Failed to create booking: $e');
    }
  }

  /// Get all bookings
  Future<List<BookingModel>> getBookings() async {
    try {
      final response = await _dio.get('/bookings');

      if (response.statusCode == 200 && response.data['success'] == true) {
        final List bookingsData = response.data['data'];
        return bookingsData
            .map((json) => BookingModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to get bookings: ${response.data}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception('Server error: ${e.response!.data['message']}');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Failed to get bookings: $e');
    }
  }

  /// Get booking by ID
  Future<BookingModel> getBookingById(String id) async {
    try {
      final response = await _dio.get('/booking/$id');

      if (response.statusCode == 200 && response.data['success'] == true) {
        return BookingModel.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to get booking: ${response.data}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 404) {
          throw Exception('Booking not found');
        }
        throw Exception('Server error: ${e.response!.data['message']}');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Failed to get booking: $e');
    }
  }

  /// Update booking status (mark as picked up)
  Future<BookingModel> updateBookingStatus(String id, bool isPickedUp) async {
    try {
      final response = await _dio.patch(
        '/booking/$id/status',
        data: {'isPickedUp': isPickedUp},
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        return BookingModel.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to update booking status: ${response.data}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 404) {
          throw Exception('Booking not found');
        }
        throw Exception('Server error: ${e.response!.data['message']}');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Failed to update booking status: $e');
    }
  }
}
