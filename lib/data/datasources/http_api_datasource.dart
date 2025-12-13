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

      // Capitalize first letter of bookingType to match API spec (Airport/Other)
      String bookingType = booking.pickupLocationType ?? 'airport';
      bookingType = bookingType[0].toUpperCase() + bookingType.substring(1).toLowerCase();

      final response = await _dio.post(
        '/booking',
        data: {
          'fullName': booking.fullName,
          'phoneNumber': booking.phoneNumber,
          'hotel': hotelId,
          'bookingType': bookingType, // Required: 'Airport' or 'Other'
          'numberOfBags': booking.numberOfBags,
          'deviceId': booking.deviceId,
          // Optional fields
          if (booking.email != null && booking.email!.isNotEmpty)
            'email': booking.email,
          // Required when bookingType is 'Other'
          if (booking.pickupLocation != null && booking.pickupLocation!.isNotEmpty)
            'pickupLocationAddress': booking.pickupLocation,
          // Required when bookingType is 'Airport'
          if (booking.arrivalTime != null && booking.arrivalTime!.isNotEmpty)
            'arrivalTime': booking.arrivalTime,
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

  /// Cancel a booking (Customer - Before Confirmation)
  /// Based on /api/booking/{id}/cancel endpoint from swagger.yaml
  /// Only allowed for bookings with status 'pending' (not yet confirmed by admin)
  Future<BookingModel> cancelBooking(String id) async {
    try {
      final response = await _dio.patch('/booking/$id/cancel');

      if (response.statusCode == 200 && response.data['success'] == true) {
        return BookingModel.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to cancel booking: ${response.data}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 404) {
          throw Exception('Booking not found');
        } else if (e.response!.statusCode == 400) {
          // Cannot cancel - booking already confirmed or in later stage
          final message = e.response!.data['message'] ?? 'Cannot cancel booking';
          throw Exception(message);
        }
        throw Exception('Server error: ${e.response!.data['message']}');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Failed to cancel booking: $e');
    }
  }

  /// Edit a booking (Customer - Before Confirmation)
  /// Based on /api/booking/{id}/edit endpoint from swagger.yaml
  /// Only allowed for bookings with status 'pending' (not yet confirmed by admin)
  Future<BookingModel> editBooking(String id, BookingModel booking) async {
    try {
      // Extract hotel ID from hotelData (could be String or Map)
      String? hotelId;
      if (booking.hotelData is Map<String, dynamic>) {
        hotelId = booking.hotelData['_id'] as String? ??
                  booking.hotelData['id'] as String?;
      } else if (booking.hotelData != null) {
        hotelId = booking.hotelData?.toString();
      }

      // Capitalize first letter of bookingType to match API spec (Airport/Other)
      String? bookingType;
      if (booking.pickupLocationType != null) {
        bookingType = booking.pickupLocationType![0].toUpperCase() +
                     booking.pickupLocationType!.substring(1).toLowerCase();
      }

      // Build request data with only non-null fields
      final Map<String, dynamic> data = {};

      if (booking.fullName.isNotEmpty) {
        data['fullName'] = booking.fullName;
      }
      if (booking.phoneNumber.isNotEmpty) {
        data['phoneNumber'] = booking.phoneNumber;
      }
      if (booking.email != null && booking.email!.isNotEmpty) {
        data['email'] = booking.email;
      }
      if (hotelId != null && hotelId.isNotEmpty) {
        data['hotel'] = hotelId;
      }
      if (bookingType != null) {
        data['bookingType'] = bookingType;
      }
      if (booking.pickupLocation != null && booking.pickupLocation!.isNotEmpty) {
        data['pickupLocationAddress'] = booking.pickupLocation;
      }
      if (booking.arrivalTime != null && booking.arrivalTime!.isNotEmpty) {
        data['arrivalTime'] = booking.arrivalTime;
      }
      if (booking.numberOfBags > 0) {
        data['numberOfBags'] = booking.numberOfBags;
      }

      final response = await _dio.patch(
        '/booking/$id/edit',
        data: data,
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        return BookingModel.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to edit booking: ${response.data}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 404) {
          throw Exception('Booking not found');
        } else if (e.response!.statusCode == 400) {
          // Cannot edit - booking already confirmed or validation error
          final message = e.response!.data['message'] ?? 'Cannot edit booking';
          final errors = e.response!.data['errors'];
          if (errors != null && errors is List && errors.isNotEmpty) {
            throw Exception('$message: ${errors.join(', ')}');
          }
          throw Exception(message);
        }
        throw Exception('Server error: ${e.response!.data['message']}');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Failed to edit booking: $e');
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
