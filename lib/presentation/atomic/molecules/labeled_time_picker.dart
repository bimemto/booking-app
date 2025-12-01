import 'package:flutter/material.dart';
import '../atoms/time_picker_field.dart';

/// Molecule: Labeled Time Picker
/// Combines a label with a time picker field
class LabeledTimePicker extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final String? hintText;
  final IconData? prefixIcon;
  final String? Function(String?)? validator;
  final bool required;
  final void Function(String)? onChanged;
  final bool enabled;

  const LabeledTimePicker({
    super.key,
    required this.label,
    this.controller,
    this.hintText,
    this.prefixIcon,
    this.validator,
    this.required = false,
    this.onChanged,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            if (required)
              const Text(
                ' *',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.red,
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        TimePickerField(
          controller: controller,
          hintText: hintText,
          prefixIcon: prefixIcon,
          validator: validator,
          onChanged: onChanged,
          enabled: enabled,
        ),
      ],
    );
  }
}
