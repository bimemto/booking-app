import 'dart:convert';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:signals_flutter/signals_flutter.dart';
import '../../core/di/injection.dart';
import '../../domain/entities/booking_entity.dart';
import '../atomic/atoms/custom_button.dart';
import '../atomic/organisms/booking_detail_card.dart';
import '../providers/booking_provider.dart';

/// Booking QR Page
/// Screen 2: Display booking details with QR code and pickup status
@RoutePage()
class BookingQRPage extends StatefulWidget {
  final BookingEntity booking;

  const BookingQRPage({
    super.key,
    required this.booking,
  });

  @override
  State<BookingQRPage> createState() => _BookingQRPageState();
}

class _BookingQRPageState extends State<BookingQRPage> {
  final _bookingProvider = getIt<BookingProvider>();
  late final Signal<BookingEntity> _booking;

  @override
  void initState() {
    super.initState();
    // Initialize local booking signal
    _booking = signal<BookingEntity>(widget.booking);
    // Set in provider
    _bookingProvider.setCurrentBooking(widget.booking);
  }

  Future<void> _handleMarkAsPickedUp() async {
    if (_booking.value.id != null) {
      // Update in Firebase
      await _bookingProvider.updateBookingStatus(
        _booking.value.id!,
        true,
      );

      // Update local state
      if (_bookingProvider.currentBooking.value != null) {
        _booking.value = _bookingProvider.currentBooking.value!;
      }
    } else {
      // Local update only (for demo without Firebase)
      _booking.value = _booking.value.copyWith(isPickedUp: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Booking QR Code',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Watch((context) {
            final currentBooking = _booking.value;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Status Badge
                if (currentBooking.isPickedUp)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          Icons.check_circle,
                          color: Colors.white,
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Status: Picked Up',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 24),

                // QR Code
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      QrImageView(
                        data: jsonEncode(currentBooking.toQRJson()),
                        version: QrVersions.auto,
                        size: 250.0,
                        backgroundColor: Colors.white,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Scan this QR code',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Booking Details
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Booking Details',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                BookingDetailCard(booking: currentBooking),
                const SizedBox(height: 32),

                // Mark as Picked Up Button
                if (!currentBooking.isPickedUp)
                  Watch((context) {
                    return CustomButton(
                      text: 'Mark as Picked Up',
                      onPressed: _handleMarkAsPickedUp,
                      isLoading: _bookingProvider.isLoading.value,
                      icon: Icons.check_circle_outline,
                      backgroundColor: Colors.green,
                    );
                  }),
              ],
            );
          }),
        ),
      ),
    );
  }
}
