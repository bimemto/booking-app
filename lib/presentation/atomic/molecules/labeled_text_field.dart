import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../atoms/custom_text_field.dart';

/// Molecule: Labeled Text Field
/// Combines a label with a text field
class LabeledTextField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final String? hintText;
  final IconData? prefixIcon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final bool required;
  final void Function(String)? onChanged;
  final bool enabled;

  const LabeledTextField({
    super.key,
    required this.label,
    this.controller,
    this.hintText,
    this.prefixIcon,
    this.keyboardType,
    this.validator,
    this.inputFormatters,
    this.maxLines = 1,
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
                color: Colors.black87,
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
        CustomTextField(
          controller: controller,
          hintText: hintText,
          prefixIcon: prefixIcon,
          keyboardType: keyboardType,
          validator: validator,
          inputFormatters: inputFormatters,
          maxLines: maxLines,
          onChanged: onChanged,
          enabled: enabled,
        ),
      ],
    );
  }
}
