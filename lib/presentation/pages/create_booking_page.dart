import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';
import '../../core/di/injection.dart';
import '../../core/routes/app_router.gr.dart';
import '../../core/services/device_id_service.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/datasources/http_api_datasource.dart';
import '../../domain/entities/booking_entity.dart';
import '../../domain/entities/hotel_entity.dart';
import '../atomic/organisms/booking_form.dart';
import '../providers/booking_provider.dart';

/// Create Booking Page
/// Screen 1: Form for creating a new booking
@RoutePage()
class CreateBookingPage extends StatefulWidget {
  final BookingEntity? existingBooking;

  const CreateBookingPage({super.key, this.existingBooking});

  @override
  State<CreateBookingPage> createState() => _CreateBookingPageState();
}

class _CreateBookingPageState extends State<CreateBookingPage> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _hotelController = TextEditingController();
  final _pickupLocationController = TextEditingController();
  final _arrivalTimeController = TextEditingController();
  int? _selectedBags;
  String? _selectedPickupType = 'Airport'; // Default to 'Airport'
  String? _selectedHotelId; // Store the selected hotel ID
  String? _selectedHotelName; // Store the selected hotel name
  String? _e164PhoneNumber; // Store E.164 formatted phone number for API

  final _bookingProvider = getIt<BookingProvider>();
  final _httpApiDatasource = getIt<HttpApiDatasource>();
  final _deviceIdService = getIt<DeviceIdService>();

  @override
  void initState() {
    super.initState();
    // If editing an existing booking, populate the form fields
    if (widget.existingBooking != null) {
      final booking = widget.existingBooking!;
      _fullNameController.text = booking.fullName;
      _emailController.text = booking.email ?? '';
      _phoneController.text = booking.phoneNumber;
      _hotelController.text = booking.hotelName ?? '';
      _pickupLocationController.text = booking.pickupLocation ?? '';
      _arrivalTimeController.text = booking.arrivalTime ?? '';
      _selectedBags = booking.numberOfBags;
      // Capitalize pickup type (airport -> Airport, other -> Other)
      final pickupType = booking.pickupLocationType;
      if (pickupType != null && pickupType.isNotEmpty) {
        _selectedPickupType = pickupType[0].toUpperCase() + pickupType.substring(1).toLowerCase();
      } else {
        _selectedPickupType = 'Airport';
      }
      _selectedHotelId = booking.hotel;
      _selectedHotelName = booking.hotelName;
      _e164PhoneNumber = booking.phoneNumber;
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _hotelController.dispose();
    _pickupLocationController.dispose();
    _arrivalTimeController.dispose();
    super.dispose();
  }

  Future<List<HotelEntity>> _searchHotels(String query) async {
    try {
      final hotels = await _httpApiDatasource.searchHotels(query: query);
      return hotels.map((model) => model.toEntity()).toList();
    } catch (e) {
      print('Error searching hotels: $e');
      return [];
    }
  }

  void _onHotelSelected(HotelEntity? hotel) {
    if (hotel != null) {
      setState(() {
        _selectedHotelId = hotel.id;
        _selectedHotelName = hotel.name;
        _hotelController.text = hotel.name; // Display name in the field
      });
    }
  }

  Future<void> _handleSubmit() async {
    // Clear any previous errors
    _bookingProvider.clearError();

    // Validate form
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Validate hotel selection
    if (_selectedHotelId == null) {
      // Show error if hotel not selected from autocomplete
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a hotel from the autocomplete list'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Get device ID
    final deviceId = await _deviceIdService.getDeviceId();

    // Create booking entity
    final email = _emailController.text.trim();
    final arrivalTime = _arrivalTimeController.text.trim();
    final pickupLocation = _pickupLocationController.text.trim();

    final booking = BookingEntity(
      id: widget.existingBooking?.id, // Include ID if editing
      fullName: _fullNameController.text.trim(),
      email: email.isEmpty ? null : email,
      phoneNumber: _e164PhoneNumber ?? _phoneController.text.trim(), // Use E.164 format if available
      numberOfBags: _selectedBags!,
      hotel: _selectedHotelId!, // Send hotel ID to API
      hotelName: _selectedHotelName, // Store hotel name for display
      pickupLocation: pickupLocation.isEmpty ? null : pickupLocation, // Only send if provided
      pickupLocationType: _selectedPickupType?.toLowerCase(), // 'airport' or 'other'
      arrivalTime: arrivalTime.isEmpty ? null : arrivalTime,
      deviceId: deviceId, // Add device ID
    );

    // Call provider to create or edit booking
    final bool success;
    if (widget.existingBooking != null) {
      // Edit existing booking
      success = await _bookingProvider.editBooking(widget.existingBooking!.id!, booking);
    } else {
      // Create new booking
      success = await _bookingProvider.createBooking(booking);
    }

    if (success && mounted) {
      if (widget.existingBooking != null) {
        // If editing, navigate back with success result
        context.router.maybePop(true);
      } else {
        // If creating, navigate to QR page
        context.router.push(
          BookingQRRoute(booking: _bookingProvider.currentBooking.value!),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: widget.existingBooking != null, // Allow pop when editing
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('Lugger'),
          backgroundColor: Colors.black,
          elevation: 0,
          automaticallyImplyLeading: widget.existingBooking != null, // Show back button when editing
          actions: [
            IconButton(
              icon: const Icon(Icons.list_alt, color: Colors.white),
              tooltip: 'My Bookings',
              onPressed: () {
                context.router.push(const MyBookingsRoute());
              },
            ),
          ],
        ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),

              // Page Title
              Text(
                widget.existingBooking != null ? 'Edit Booking' : 'Book a Pickup',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w400,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 32),

              // Form
              BookingForm(
                formKey: _formKey,
                fullNameController: _fullNameController,
                emailController: _emailController,
                phoneController: _phoneController,
                hotelController: _hotelController,
                pickupLocationController: _pickupLocationController,
                arrivalTimeController: _arrivalTimeController,
                selectedBags: _selectedBags,
                selectedPickupType: _selectedPickupType,
                onBagsChanged: (value) {
                  setState(() {
                    _selectedBags = value;
                  });
                },
                onPickupTypeChanged: (value) {
                  setState(() {
                    _selectedPickupType = value;
                    // Clear arrival time if switching from Airport to Other
                    if (value != 'Airport') {
                      _arrivalTimeController.clear();
                    }
                    // Clear pickup location if switching to Airport
                    if (value == 'Airport') {
                      _pickupLocationController.clear();
                    }
                  });
                },
                onHotelSearch: _searchHotels,
                onHotelSelected: _onHotelSelected,
                onPhoneChanged: (e164Number) {
                  setState(() {
                    _e164PhoneNumber = e164Number;
                  });
                },
              ),
              const SizedBox(height: 40),

              // Submit Button
              Watch((context) {
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _bookingProvider.isLoading.value ? null : _handleSubmit,
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
                        : Text(
                            widget.existingBooking != null ? 'Update Booking' : 'Book Now',
                            style: AppTextStyles.buttonPrimary,
                          ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
      ),
    );
  }
}
