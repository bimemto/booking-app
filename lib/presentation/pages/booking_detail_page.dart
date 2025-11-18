import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';
import '../../core/di/injection.dart';
import '../../domain/entities/booking_entity.dart';
import '../atomic/atoms/custom_button.dart';
import '../atomic/organisms/booking_form.dart';
import '../providers/booking_provider.dart';

/// Booking Detail Page
/// Shows booking details with pre-filled data
/// Can be used to view or edit booking information
@RoutePage()
class BookingDetailPage extends StatefulWidget {
  final BookingEntity booking;

  const BookingDetailPage({
    super.key,
    required this.booking,
  });

  @override
  State<BookingDetailPage> createState() => _BookingDetailPageState();
}

class _BookingDetailPageState extends State<BookingDetailPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _fullNameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _pickupController;
  late final TextEditingController _dropoffController;
  late int? _selectedBags;

  final _bookingProvider = getIt<BookingProvider>();

  @override
  void initState() {
    super.initState();

    // Initialize controllers with booking data
    _fullNameController = TextEditingController(text: widget.booking.fullName);
    _phoneController = TextEditingController(text: widget.booking.phoneNumber);
    _pickupController = TextEditingController(text: widget.booking.pickupLocation);
    _dropoffController = TextEditingController(text: widget.booking.dropoffLocation);
    _selectedBags = widget.booking.numberOfBags;
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _pickupController.dispose();
    _dropoffController.dispose();
    super.dispose();
  }

  Future<void> _handleMarkAsPickedUp() async {
    if (widget.booking.id == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cannot update booking: ID is missing'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    await _bookingProvider.updateBookingStatus(
      widget.booking.id!,
      !widget.booking.isPickedUp,
    );

    if (mounted && _bookingProvider.errorMessage.value == null) {
      // Update successful, go back
      context.router.maybePop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          widget.booking.id != null ? 'Booking #${widget.booking.id}' : 'Booking Details',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Status card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: widget.booking.isPickedUp
                      ? Colors.green[50]
                      : Colors.orange[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: widget.booking.isPickedUp
                        ? Colors.green[200]!
                        : Colors.orange[200]!,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      widget.booking.isPickedUp
                          ? Icons.check_circle
                          : Icons.pending,
                      color: widget.booking.isPickedUp
                          ? Colors.green[700]
                          : Colors.orange[700],
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.booking.isPickedUp
                                ? 'Status: Picked Up'
                                : 'Status: Pending',
                            style: TextStyle(
                              color: widget.booking.isPickedUp
                                  ? Colors.green[900]
                                  : Colors.orange[900],
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (widget.booking.createdAt != null) ...[
                            const SizedBox(height: 4),
                            Text(
                              'Created: ${_formatDateTime(widget.booking.createdAt!)}',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Booking details header
              const Text(
                'Booking Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // Form (read-only mode)
              BookingForm(
                formKey: _formKey,
                fullNameController: _fullNameController,
                phoneController: _phoneController,
                pickupController: _pickupController,
                dropoffController: _dropoffController,
                selectedBags: _selectedBags,
                onBagsChanged: (value) {
                  setState(() {
                    _selectedBags = value;
                  });
                },
                isReadOnly: true,
              ),
              const SizedBox(height: 32),

              // Mark as picked up button (only if not already picked up)
              if (!widget.booking.isPickedUp && widget.booking.id != null)
                Watch((context) {
                  return CustomButton(
                    text: 'Mark as Picked Up',
                    onPressed: _handleMarkAsPickedUp,
                    isLoading: _bookingProvider.isLoading.value,
                    icon: Icons.check_circle,
                    backgroundColor: Colors.green,
                  );
                }),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}
