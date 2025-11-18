import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';
import '../../core/di/injection.dart';
import '../../core/routes/app_router.gr.dart';
import '../../domain/entities/booking_entity.dart';
import '../atomic/atoms/custom_button.dart';
import '../atomic/organisms/booking_form.dart';
import '../providers/booking_provider.dart';

/// Create Booking Page
/// Screen 1: Form for creating a new booking
@RoutePage()
class CreateBookingPage extends StatefulWidget {
  const CreateBookingPage({super.key});

  @override
  State<CreateBookingPage> createState() => _CreateBookingPageState();
}

class _CreateBookingPageState extends State<CreateBookingPage> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _pickupController = TextEditingController();
  final _dropoffController = TextEditingController();
  int? _selectedBags;

  final _bookingProvider = getIt<BookingProvider>();

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _pickupController.dispose();
    _dropoffController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    // Clear any previous errors
    _bookingProvider.clearError();

    // Validate form
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Create booking entity
    final booking = BookingEntity(
      fullName: _fullNameController.text.trim(),
      phoneNumber: _phoneController.text.trim(),
      pickupLocation: _pickupController.text.trim(),
      dropoffLocation: _dropoffController.text.trim(),
      numberOfBags: _selectedBags!,
    );

    // Call provider to create booking
    final success = await _bookingProvider.createBooking(booking);

    if (success && mounted) {
      // Navigate to QR page
      context.router.push(
        BookingQRRoute(booking: _bookingProvider.currentBooking.value!),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Create Booking',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.local_shipping),
            onPressed: () {
              context.router.push(const DriverRoute());
            },
            tooltip: 'Driver Mode',
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Instructions
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue[200]!),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.blue[700]),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Please fill in all required fields to create your booking',
                        style: TextStyle(
                          color: Colors.blue[900],
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Form
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
              ),
              const SizedBox(height: 32),

              // Submit Button
              Watch((context) {
                return CustomButton(
                  text: 'Generate QR Code',
                  onPressed: _handleSubmit,
                  isLoading: _bookingProvider.isLoading.value,
                  icon: Icons.qr_code,
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
