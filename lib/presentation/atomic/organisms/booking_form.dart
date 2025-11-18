import 'package:flutter/material.dart';
import '../molecules/labeled_text_field.dart';
import '../molecules/labeled_dropdown.dart';

/// Organism: Booking Form
/// Complex form component for creating bookings
class BookingForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController fullNameController;
  final TextEditingController phoneController;
  final TextEditingController pickupController;
  final TextEditingController dropoffController;
  final int? selectedBags;
  final Function(int?) onBagsChanged;
  final bool isReadOnly;

  const BookingForm({
    super.key,
    required this.formKey,
    required this.fullNameController,
    required this.phoneController,
    required this.pickupController,
    required this.dropoffController,
    required this.selectedBags,
    required this.onBagsChanged,
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
            label: 'Full Name',
            controller: fullNameController,
            hintText: 'Enter your full name',
            prefixIcon: Icons.person_outline,
            required: true,
            enabled: !isReadOnly,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Full name is required';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),

          // Phone Number Field
          LabeledTextField(
            label: 'Phone Number',
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

          // Pickup Location Field
          LabeledTextField(
            label: 'Pickup Location',
            controller: pickupController,
            hintText: 'Enter pickup address',
            prefixIcon: Icons.location_on_outlined,
            required: true,
            enabled: !isReadOnly,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Pickup location is required';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),

          // Dropoff Location Field
          LabeledTextField(
            label: 'Dropoff Location',
            controller: dropoffController,
            hintText: 'Enter dropoff address',
            prefixIcon: Icons.location_on,
            required: true,
            enabled: !isReadOnly,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Dropoff location is required';
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
            itemLabel: (bags) => '$bags ${bags == 1 ? 'bag' : 'bags'}',
            onChanged: onBagsChanged,
            hintText: 'Select number of bags',
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
        ],
      ),
    );
  }
}
