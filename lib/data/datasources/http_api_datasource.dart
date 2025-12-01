import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import '../models/booking_model.dart';
import '../models/hotel_model.dart';

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
      // Extract hotel ID from hotelData (could be String or Map)
      String hotelId;
      if (booking.hotelData is Map<String, dynamic>) {
        hotelId = booking.hotelData['_id'] as String? ??
                  booking.hotelData['id'] as String? ?? '';
      } else {
        hotelId = booking.hotelData?.toString() ?? '';
      }

      final response = await _dio.post(
        '/booking',
        data: {
          'fullName': booking.fullName,
          'email': booking.email,
          'phoneNumber': booking.phoneNumber,
          'numberOfBags': booking.numberOfBags,
          'hotel': hotelId,
          'arrivalTime': booking.arrivalTime,
          'deviceId': booking.deviceId,
          if (booking.notes != null) 'notes': booking.notes,
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

  /// Get my bookings by deviceId (Public - No Auth)
  /// Based on /api/bookings/my-bookings endpoint from swagger.yaml
  /// Returns all bookings for a specific device
  Future<List<BookingModel>> getMyBookings(String deviceId) async {
    try {
      final response = await _dio.get(
        '/bookings/my-bookings',
        queryParameters: {'deviceId': deviceId},
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        final List bookingsData = response.data['data'];
        return bookingsData
            .map((json) => BookingModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to get my bookings: ${response.data}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception('Server error: ${e.response!.data['message']}');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Failed to get my bookings: $e');
    }
  }

  /// Search hotels for autocomplete
  /// Based on /api/hotels/search endpoint from swagger.yaml (Public - No Auth)
  /// Returns only active hotels for mobile app use
  Future<List<HotelModel>> searchHotels({String? query, String? zone}) async {
    try {
      final queryParams = <String, dynamic>{};
      if (query != null && query.isNotEmpty) {
        queryParams['q'] = query;
      }
      if (zone != null && zone.isNotEmpty) {
        queryParams['zone'] = zone;
      }

      final response = await _dio.get(
        '/hotels/search',
        queryParameters: queryParams,
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        final List hotelsData = response.data['data'];
        return hotelsData.map((json) => HotelModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to search hotels: ${response.data}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception('Server error: ${e.response!.data['message']}');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Failed to search hotels: $e');
    }
  }
}
