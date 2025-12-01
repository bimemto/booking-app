import 'package:flutter/material.dart';
import '../../../domain/entities/hotel_entity.dart';
import '../molecules/labeled_text_field.dart';
import '../molecules/labeled_dropdown.dart';
import '../molecules/labeled_time_picker.dart';
import '../molecules/labeled_autocomplete.dart';

/// Organism: Booking Form
/// Complex form component for creating bookings
class BookingForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController hotelController;
  final TextEditingController arrivalTimeController;
  final int? selectedBags;
  final Function(int?) onBagsChanged;
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
    required this.arrivalTimeController,
    required this.selectedBags,
    required this.onBagsChanged,
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

          // Phone Number Field
          LabeledTextField(
            label: 'Phone',
            controller: phoneController,
            hintText: '0901234567',
            prefixIcon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
            required: true,
            enabled: !isReadOnly,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Phone number is required';
              }
              final phoneRegex = RegExp(r'^0\d{9,10}$');
              if (!phoneRegex.hasMatch(value.trim())) {
                return 'Invalid phone number (must start with 0 and be 10-11 digits)';
              }
              return null;
            },
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

          // Arrival Time Field
          LabeledTimePicker(
            label: 'Arrival Time',
            controller: arrivalTimeController,
            hintText: 'Select time',
            prefixIcon: Icons.access_time,
            required: true,
            enabled: !isReadOnly,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Arrival time is required';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
