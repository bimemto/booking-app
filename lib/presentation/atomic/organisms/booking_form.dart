import 'package:flutter/material.dart';
import '../../../domain/entities/hotel_entity.dart';
import '../molecules/labeled_text_field.dart';
import '../molecules/labeled_dropdown.dart';
import '../molecules/labeled_time_picker.dart';
import '../molecules/labeled_autocomplete.dart';
import '../molecules/labeled_location_autocomplete.dart';
import '../molecules/labeled_phone_field.dart';

/// Organism: Booking Form
/// Complex form component for creating bookings
class BookingForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController hotelController;
  final TextEditingController pickupLocationController;
  final TextEditingController arrivalTimeController;
  final int? selectedBags;
  final String? selectedPickupType;
  final Function(int?) onBagsChanged;
  final Function(String?) onPickupTypeChanged;
  final Future<List<HotelEntity>> Function(String) onHotelSearch;
  final Function(HotelEntity?) onHotelSelected;
  final bool isReadOnly;

  const BookingForm({
    super.key,
    required this.formKey,
    required this.fullNameController,
    required this.emailController,
    required this.phoneController,
    required this.hotelController,
    required this.pickupLocationController,
    required this.arrivalTimeController,
    required this.selectedBags,
    required this.selectedPickupType,
    required this.onBagsChanged,
    required this.onPickupTypeChanged,
    required this.onHotelSearch,
    required this.onHotelSelected,
    this.isReadOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Full Name Field
          LabeledTextField(
            label: 'Name',
            controller: fullNameController,
            hintText: 'Enter your name',
            prefixIcon: Icons.person_outline,
            required: true,
            enabled: !isReadOnly,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Name is required';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),

          // Email Field (Optional)
          LabeledTextField(
            label: 'Email',
            controller: emailController,
            hintText: 'your@email.com (optional)',
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            required: false,
            enabled: !isReadOnly,
            validator: (value) {
              // Only validate format if email is provided
              if (value != null && value.trim().isNotEmpty) {
                final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                if (!emailRegex.hasMatch(value.trim())) {
                  return 'Invalid email format';
                }
              }
              return null;
            },
          ),
          const SizedBox(height: 20),

          // Phone Number Field with International Support
          LabeledPhoneField(
            label: 'Phone',
            controller: phoneController,
            prefixIcon: Icons.phone_outlined,
            required: true,
            enabled: !isReadOnly,
            initialCountryCode: 'VN', // Default to Vietnam
          ),
          const SizedBox(height: 20),

          // Number of Bags Dropdown
          LabeledDropdown<int>(
            label: 'Number of Bags',
            value: selectedBags,
            items: const [1, 2, 3, 4, 5],
            itemLabel: (bags) => '$bags',
            onChanged: onBagsChanged,
            hintText: 'Select',
            prefixIcon: Icons.luggage_outlined,
            required: true,
            enabled: !isReadOnly,
            validator: (value) {
              if (value == null) {
                return 'Please select number of bags';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),

          // Hotel Autocomplete Field
          if (isReadOnly)
            LabeledTextField(
              label: 'Hotel',
              controller: hotelController,
              hintText: 'Enter hotel name',
              prefixIcon: Icons.hotel_outlined,
              required: true,
              enabled: false,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Hotel is required';
                }
                return null;
              },
            )
          else
            LabeledAutocomplete(
              label: 'Hotel',
              controller: hotelController,
              hintText: 'Search hotel name',
              prefixIcon: Icons.hotel_outlined,
              required: true,
              enabled: !isReadOnly,
              onSearch: onHotelSearch,
              onSelected: onHotelSelected,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Hotel is required';
                }
                return null;
              },
            ),
          const SizedBox(height: 20),

          // Pickup Location Type Dropdown
          LabeledDropdown<String>(
            label: 'Pickup Location Type',
            value: selectedPickupType,
            items: const ['Airport', 'Other'],
            itemLabel: (type) => type,
            onChanged: onPickupTypeChanged,
            hintText: 'Select',
            prefixIcon: Icons.location_on_outlined,
            required: true,
            enabled: !isReadOnly,
            validator: (value) {
              if (value == null) {
                return 'Please select pickup location type';
              }
              return null;
            },
          ),

          // Pickup Location Address Field (Only show if NOT Airport)
          if (selectedPickupType != 'Airport') ...[
            const SizedBox(height: 20),
            LabeledLocationAutocomplete(
              label: 'Pickup Location Address',
              controller: pickupLocationController,
              hintText: 'Search for a location...',
              prefixIcon: Icons.place_outlined,
              required: true,
              enabled: !isReadOnly,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Pickup location is required';
                }
                return null;
              },
              onPlaceSelected: (place) {
                // Location selected from autocomplete
                if (place != null) {
                  pickupLocationController.text = place.displayName;
                }
              },
            ),
            const SizedBox(height: 20),
          ],

          // Arrival Time Field (Conditional - Required only for Airport)
          LabeledTimePicker(
            label: selectedPickupType == 'Airport'
                ? 'Arrival Time'
                : 'Arrival Time (Optional)',
            controller: arrivalTimeController,
            hintText: 'Select time',
            prefixIcon: Icons.access_time,
            required: selectedPickupType == 'Airport',
            enabled: !isReadOnly,
            validator: (value) {
              if (selectedPickupType == 'Airport' &&
                  (value == null || value.trim().isEmpty)) {
                return 'Arrival time is required for Airport pickup';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
