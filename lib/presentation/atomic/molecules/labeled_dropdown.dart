import 'package:flutter/material.dart';
import '../atoms/custom_dropdown.dart';

/// Molecule: Labeled Dropdown
/// Combines a label with a dropdown
class LabeledDropdown<T> extends StatelessWidget {
  final String label;
  final T? value;
  final List<T> items;
  final String Function(T) itemLabel;
  final void Function(T?)? onChanged;
  final String? hintText;
  final IconData? prefixIcon;
  final String? Function(T?)? validator;
  final bool required;
  final bool enabled;

  const LabeledDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.itemLabel,
    this.onChanged,
    this.hintText,
    this.prefixIcon,
    this.validator,
    this.required = false,
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
        CustomDropdown<T>(
          value: value,
          items: items,
          itemLabel: itemLabel,
          onChanged: onChanged,
          hintText: hintText,
          prefixIcon: prefixIcon,
          validator: validator,
          enabled: enabled,
        ),
      ],
    );
  }
}
