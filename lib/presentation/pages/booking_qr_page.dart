import 'dart:convert';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:signals_flutter/signals_flutter.dart';
import '../../core/di/injection.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/utils/map_launcher.dart';
import '../../domain/entities/booking_entity.dart';
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

  Future<void> _handleCheckStatus() async {
    if (_booking.value.id != null) {
      // Refresh booking from API to check if status changed
      final success = await _bookingProvider.refreshBooking(_booking.value.id!);

      // Update local state if refresh was successful
      if (success && _bookingProvider.currentBooking.value != null) {
        _booking.value = _bookingProvider.currentBooking.value!;
      }
    }
  }

  Future<void> _handleCancelBooking() async {
    if (_booking.value.id == null) return;

    // Show confirmation dialog
    final shouldCancel = await SmartDialog.show<bool>(
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey.shade900,
          title: const Text(
            'Cancel Booking',
            style: TextStyle(color: Colors.white),
          ),
          content: const Text(
            'Are you sure you want to cancel this booking? This action cannot be undone.',
            style: TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () => SmartDialog.dismiss(result: false),
              child: const Text(
                'No',
                style: TextStyle(color: Colors.white60),
              ),
            ),
            TextButton(
              onPressed: () => SmartDialog.dismiss(result: true),
              style: TextButton.styleFrom(
                backgroundColor: Colors.red.shade800,
              ),
              child: const Text(
                'Yes, Cancel',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );

    if (shouldCancel == true) {
      final success = await _bookingProvider.cancelBooking(_booking.value.id!);

      // Update local state if cancellation was successful
      if (success && _bookingProvider.currentBooking.value != null) {
        _booking.value = _bookingProvider.currentBooking.value!;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Lugger'),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Watch((context) {
            final currentBooking = _booking.value;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),

                // Status Badge (if picked up)
                if (currentBooking.isPickedUp) ...[
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
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
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],

                // Booking Details Section
                const Text(
                  'Booking Details',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 24),

                _buildDetailRow('Name', currentBooking.fullName),
                if (currentBooking.email != null && currentBooking.email!.isNotEmpty)
                  _buildDetailRow('Email', currentBooking.email!),
                _buildDetailRow('Phone', currentBooking.phoneNumber),
                _buildDetailRow('Number of Bags', '${currentBooking.numberOfBags}'),
                _buildDetailRow('Hotel', currentBooking.hotelDisplayName),
                if (currentBooking.hotelAddress != null && currentBooking.hotelAddress!.isNotEmpty)
                  _buildDetailRow('Hotel Address', currentBooking.hotelAddress!),

                // Pickup Location with Maps button
                if (currentBooking.pickupLocation != null && currentBooking.pickupLocation!.isNotEmpty)
                  _buildLocationRow('Pickup Location', currentBooking.pickupLocation!),

                // Pickup Type
                if (currentBooking.pickupLocationType != null && currentBooking.pickupLocationType!.isNotEmpty)
                  _buildDetailRow('Pickup Type', currentBooking.pickupLocationType!.toUpperCase()),

                // Arrival Time (only shown if provided)
                if (currentBooking.arrivalTime != null && currentBooking.arrivalTime!.isNotEmpty)
                  _buildDetailRow('Arrival Time', currentBooking.arrivalTime!),

                const SizedBox(height: 40),

                // QR Code Section or Status Section
                if (currentBooking.status?.toLowerCase() == 'cancelled') ...[
                  // Show cancelled status
                  const Text(
                    'Booking Status',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Cancelled Badge
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red.shade900.withValues(alpha: 0.3),
                        border: Border.all(
                          color: Colors.red.shade700,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.cancel_outlined,
                            color: Colors.red.shade400,
                            size: 48,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'CANCELLED',
                            style: TextStyle(
                              color: Colors.red.shade400,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'This booking has been cancelled',
                            style: TextStyle(
                              color: Colors.red.shade300.withValues(alpha: 0.7),
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ] else if (currentBooking.isConfirmed) ...[
                  // Show QR Code only when booking is confirmed
                  const Text(
                    'QR Code',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // QR Code
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: QrImageView(
                        data: jsonEncode(currentBooking.toQRJson()),
                        version: QrVersions.auto,
                        size: 250.0,
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                ] else ...[
                  // Show status message when not confirmed
                  const Text(
                    'Booking Status',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Status Badge
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade800,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.pending_actions,
                            color: Colors.white,
                            size: 48,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            currentBooking.status?.toUpperCase() ?? 'PENDING',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'QR code will be available once confirmed',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Check Status Button
                  Watch((context) {
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _bookingProvider.isLoading.value
                            ? null
                            : _handleCheckStatus,
                        style: AppButtonStyles.primaryOutlined,
                        child: _bookingProvider.isLoading.value
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.refresh,
                                    size: 20,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Check Status',
                                    style: AppTextStyles.buttonPrimary,
                                  ),
                                ],
                              ),
                      ),
                    );
                  }),

                  const SizedBox(height: 16),

                  // Cancel Booking Button
                  Watch((context) {
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _bookingProvider.isLoading.value
                            ? null
                            : _handleCancelBooking,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.red.shade400,
                          side: BorderSide(
                            color: Colors.red.shade400,
                            width: 1,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: _bookingProvider.isLoading.value
                            ? SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.red.shade400,
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.cancel_outlined,
                                    size: 20,
                                    color: Colors.red.shade400,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Cancel Booking',
                                    style: TextStyle(
                                      color: Colors.red.shade400,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1.0,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    );
                  }),
                ],

                const SizedBox(height: 40),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white60,
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationRow(String label, String address) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white60,
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Text(
                  address,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              OutlinedButton.icon(
                onPressed: () async {
                  final success = await MapLauncher.openAddress(address);
                  if (!success && mounted) {
                    SmartDialog.showToast('Could not open Maps');
                  }
                },
                icon: const Icon(Icons.directions, size: 18),
                label: const Text('Navigate'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white24, width: 1),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
