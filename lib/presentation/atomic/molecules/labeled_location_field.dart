import 'package:flutter/material.dart';
import '../../../core/theme/app_text_styles.dart';

/// Molecule: Labeled Location Field
/// Simple location text input field
class LabeledLocationField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? hintText;
  final IconData? prefixIcon;
  final bool required;
  final bool enabled;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;

  const LabeledLocationField({
    super.key,
    required this.label,
    required this.controller,
    this.hintText,
    this.prefixIcon,
    this.required = false,
    this.enabled = true,
    this.validator,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Row(
          children: [
            Text(
              label,
              style: AppTextStyles.bodySmall.copyWith(
                color: Colors.white70,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (required)
              const Text(
                ' *',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),

        // Text Field
        TextFormField(
          controller: controller,
          enabled: enabled,
          readOnly: onTap != null,
          onTap: onTap,
          style: const TextStyle(color: Colors.white, fontSize: 16),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.white38),
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, color: Colors.white70, size: 20)
                : null,
            suffixIcon: controller.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.directions, color: Colors.white70, size: 20),
                    onPressed: enabled ? () => _openInMaps(context) : null,
                    tooltip: 'Open in Maps',
                  )
                : null,
            filled: true,
            fillColor: Colors.white.withValues(alpha: 0.05),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.white24, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.white24, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.white, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.white12, width: 1),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
          validator: validator,
          maxLines: 2,
          minLines: 1,
        ),
      ],
    );
  }

  void _openInMaps(BuildContext context) async {
    final address = controller.text.trim();
    if (address.isEmpty) return;

    try {
      // Show info message - actual navigation is handled in booking QR page
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Address: $address'),
          duration: const Duration(seconds: 2),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not process address'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
