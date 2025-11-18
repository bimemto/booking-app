import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import '../models/booking_model.dart';

/// Firebase datasource for booking operations
/// Handles all Firebase Firestore interactions
@lazySingleton
class FirebaseDatasource {
  final FirebaseFirestore _firestore;
  static const String _collectionName = 'bookings';

  FirebaseDatasource(this._firestore);

  /// Create a new booking in Firestore
  Future<BookingModel> createBooking(BookingModel booking) async {
    try {
      final docRef = await _firestore.collection(_collectionName).add(
            booking.toFirestore(),
          );

      // Get the created document to return with ID and server timestamp
      final doc = await docRef.get();
      return BookingModel.fromFirestore(doc);
    } catch (e) {
      throw Exception('Failed to create booking: $e');
    }
  }

  /// Get all bookings from Firestore
  Future<List<BookingModel>> getBookings() async {
    try {
      final snapshot = await _firestore
          .collection(_collectionName)
          .orderBy('createdAt', descending: true)
          .limit(50)
          .get();

      return snapshot.docs
          .map((doc) => BookingModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to get bookings: $e');
    }
  }

  /// Get a booking by ID
  Future<BookingModel> getBookingById(String id) async {
    try {
      final doc = await _firestore.collection(_collectionName).doc(id).get();

      if (!doc.exists) {
        throw Exception('Booking not found');
      }

      return BookingModel.fromFirestore(doc);
    } catch (e) {
      throw Exception('Failed to get booking: $e');
    }
  }

  /// Update booking status
  Future<BookingModel> updateBookingStatus(String id, bool isPickedUp) async {
    try {
      final docRef = _firestore.collection(_collectionName).doc(id);

      await docRef.update({
        'isPickedUp': isPickedUp,
      });

      // Get updated document
      final doc = await docRef.get();
      return BookingModel.fromFirestore(doc);
    } catch (e) {
      throw Exception('Failed to update booking status: $e');
    }
  }

  /// Delete a booking (optional - for future use)
  Future<void> deleteBooking(String id) async {
    try {
      await _firestore.collection(_collectionName).doc(id).delete();
    } catch (e) {
      throw Exception('Failed to delete booking: $e');
    }
  }

  /// Listen to bookings stream (optional - for real-time updates)
  Stream<List<BookingModel>> watchBookings() {
    return _firestore
        .collection(_collectionName)
        .orderBy('createdAt', descending: true)
        .limit(50)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => BookingModel.fromFirestore(doc)).toList());
  }
}
