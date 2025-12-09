import 'package:flutter/material.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';

/// Molecule: Labeled Phone Number Field
/// Text field with country code selector for international phone numbers
class LabeledPhoneField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final String hintText;
  final IconData? prefixIcon;
  final bool required;
  final bool enabled;
  final String? Function(String?)? validator;
  final String? initialCountryCode; // ISO 3166-1 alpha-2 code (e.g., 'VN', 'US')
  final Function(String?)? onPhoneChanged; // Callback with E.164 formatted number

  const LabeledPhoneField({
    super.key,
    required this.label,
    required this.controller,
    this.hintText = '',
    this.prefixIcon,
    this.required = false,
    this.enabled = true,
    this.validator,
    this.initialCountryCode = 'VN', // Default to Vietnam
    this.onPhoneChanged,
  });

  @override
  State<LabeledPhoneField> createState() => _LabeledPhoneFieldState();
}

class _LabeledPhoneFieldState extends State<LabeledPhoneField> {
  late String _selectedCountryCode;
  String? _formattedNumber;
  String? _e164Number; // Store E.164 format for API submission
  bool _isInitialized = false;
  bool? _lastValidationResult;

  @override
  void initState() {
    super.initState();
    _selectedCountryCode = widget.initialCountryCode ?? 'VN';
    _initializeLibPhoneNumber();
  }

  Future<void> _initializeLibPhoneNumber() async {
    try {
      await init();
      setState(() {
        _isInitialized = true;
      });
    } catch (e) {
      debugPrint('Error initializing libphonenumber: $e');
    }
  }

  // Get hint text based on selected country code
  String _getPhoneHint() {
    switch (_selectedCountryCode) {
      // Asia
      case 'VN': return '0901234567'; // VN mobile numbers start with 0
      case 'CN': return '131 2345 6789';
      case 'JP': return '90 1234 5678';
      case 'KR': return '10 1234 5678';
      case 'SG': return '8123 4567';
      case 'TH': return '81 234 5678';
      case 'MY': return '12 345 6789';
      case 'ID': return '812 3456 7890';
      case 'PH': return '905 123 4567';
      case 'IN': return '98765 43210';
      case 'HK': return '5123 4567';
      case 'TW': return '912 345 678';
      case 'BD': return '1712 345678';
      case 'PK': return '300 1234567';
      case 'LK': return '71 234 5678';
      case 'MM': return '9 123 456 789';
      case 'KH': return '12 345 678';
      case 'LA': return '20 1234 5678';
      case 'MN': return '8812 3456';

      // North America
      case 'US':
      case 'CA': return '(201) 555-0123';
      case 'MX': return '55 1234 5678';

      // South America
      case 'BR': return '11 91234-5678';
      case 'AR': return '11 1234-5678';
      case 'CL': return '9 1234 5678';
      case 'CO': return '321 1234567';
      case 'PE': return '912 345 678';

      // Europe
      case 'GB': return '7400 123456';
      case 'FR': return '6 12 34 56 78';
      case 'DE': return '151 23456789';
      case 'IT': return '312 345 6789';
      case 'ES': return '612 34 56 78';
      case 'NL': return '6 12345678';
      case 'BE': return '470 12 34 56';
      case 'CH': return '78 123 45 67';
      case 'AT': return '664 123456';
      case 'SE': return '70 123 45 67';
      case 'NO': return '412 34 567';
      case 'DK': return '32 12 34 56';
      case 'FI': return '41 2345678';
      case 'PL': return '512 345 678';
      case 'RU': return '912 345-67-89';
      case 'TR': return '501 234 56 78';
      case 'GR': return '691 234 5678';
      case 'PT': return '912 345 678';
      case 'CZ': return '601 123 456';
      case 'HU': return '20 123 4567';
      case 'RO': return '712 345 678';
      case 'UA': return '50 123 4567';

      // Oceania
      case 'AU': return '412 345 678';
      case 'NZ': return '21 123 4567';

      // Middle East
      case 'AE': return '50 123 4567';
      case 'SA': return '50 123 4567';
      case 'IL': return '50 123 4567';
      case 'QA': return '3312 3456';
      case 'KW': return '500 12345';

      // Africa
      case 'ZA': return '71 123 4567';
      case 'EG': return '100 123 4567';
      case 'NG': return '802 123 4567';
      case 'KE': return '712 345678';

      default: return widget.hintText.isNotEmpty ? widget.hintText : 'Enter phone number';
    }
  }

  Future<void> _formatAndValidatePhoneNumber(String input) async {
    if (!_isInitialized || input.isEmpty) {
      setState(() {
        _formattedNumber = null;
        _lastValidationResult = null;
      });
      return;
    }

    try {
      // Parse and format the number
      final result = await parse(input, region: _selectedCountryCode);

      // Validate the number - must be a valid type AND have proper formatting
      final type = result['type'] as String?;
      final isValid = type != null &&
                      type != 'notANumber' &&
                      type != 'unknown' &&
                      result['e164'] != null; // E164 format must exist for truly valid numbers

      setState(() {
        if (isValid) {
          _formattedNumber = result['international'] as String?;
          _e164Number = result['e164'] as String?;
          // Notify parent with E.164 formatted number
          widget.onPhoneChanged?.call(_e164Number);
        } else {
          _formattedNumber = null;
          _e164Number = null;
          widget.onPhoneChanged?.call(null);
        }
        _lastValidationResult = isValid;
      });
    } catch (e) {
      setState(() {
        _formattedNumber = null;
        _lastValidationResult = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Row(
          children: [
            Text(
              widget.label,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 11,
                fontWeight: FontWeight.w300,
                letterSpacing: 1.5,
              ),
            ),
            if (widget.required)
              const Text(
                ' *',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 11,
                ),
              ),
          ],
        ),
        const SizedBox(height: 12),

        // Phone Input with Country Selector
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Country Code Selector
            Container(
              height: 56,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white24),
                borderRadius: BorderRadius.circular(4),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedCountryCode,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  dropdownColor: Colors.grey[900],
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.white70),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  items: const [
                    // Asia
                    DropdownMenuItem(value: 'VN', child: Text('🇻🇳 +84')),
                    DropdownMenuItem(value: 'CN', child: Text('🇨🇳 +86')),
                    DropdownMenuItem(value: 'JP', child: Text('🇯🇵 +81')),
                    DropdownMenuItem(value: 'KR', child: Text('🇰🇷 +82')),
                    DropdownMenuItem(value: 'SG', child: Text('🇸🇬 +65')),
                    DropdownMenuItem(value: 'TH', child: Text('🇹🇭 +66')),
                    DropdownMenuItem(value: 'MY', child: Text('🇲🇾 +60')),
                    DropdownMenuItem(value: 'ID', child: Text('🇮🇩 +62')),
                    DropdownMenuItem(value: 'PH', child: Text('🇵🇭 +63')),
                    DropdownMenuItem(value: 'IN', child: Text('🇮🇳 +91')),
                    DropdownMenuItem(value: 'HK', child: Text('🇭🇰 +852')),
                    DropdownMenuItem(value: 'TW', child: Text('🇹🇼 +886')),
                    DropdownMenuItem(value: 'BD', child: Text('🇧🇩 +880')),
                    DropdownMenuItem(value: 'PK', child: Text('🇵🇰 +92')),
                    DropdownMenuItem(value: 'LK', child: Text('🇱🇰 +94')),
                    DropdownMenuItem(value: 'MM', child: Text('🇲🇲 +95')),
                    DropdownMenuItem(value: 'KH', child: Text('🇰🇭 +855')),
                    DropdownMenuItem(value: 'LA', child: Text('🇱🇦 +856')),
                    DropdownMenuItem(value: 'MN', child: Text('🇲🇳 +976')),

                    // North America
                    DropdownMenuItem(value: 'US', child: Text('🇺🇸 +1')),
                    DropdownMenuItem(value: 'CA', child: Text('🇨🇦 +1')),
                    DropdownMenuItem(value: 'MX', child: Text('🇲🇽 +52')),

                    // South America
                    DropdownMenuItem(value: 'BR', child: Text('🇧🇷 +55')),
                    DropdownMenuItem(value: 'AR', child: Text('🇦🇷 +54')),
                    DropdownMenuItem(value: 'CL', child: Text('🇨🇱 +56')),
                    DropdownMenuItem(value: 'CO', child: Text('🇨🇴 +57')),
                    DropdownMenuItem(value: 'PE', child: Text('🇵🇪 +51')),

                    // Europe
                    DropdownMenuItem(value: 'GB', child: Text('🇬🇧 +44')),
                    DropdownMenuItem(value: 'FR', child: Text('🇫🇷 +33')),
                    DropdownMenuItem(value: 'DE', child: Text('🇩🇪 +49')),
                    DropdownMenuItem(value: 'IT', child: Text('🇮🇹 +39')),
                    DropdownMenuItem(value: 'ES', child: Text('🇪🇸 +34')),
                    DropdownMenuItem(value: 'NL', child: Text('🇳🇱 +31')),
                    DropdownMenuItem(value: 'BE', child: Text('🇧🇪 +32')),
                    DropdownMenuItem(value: 'CH', child: Text('🇨🇭 +41')),
                    DropdownMenuItem(value: 'AT', child: Text('🇦🇹 +43')),
                    DropdownMenuItem(value: 'SE', child: Text('🇸🇪 +46')),
                    DropdownMenuItem(value: 'NO', child: Text('🇳🇴 +47')),
                    DropdownMenuItem(value: 'DK', child: Text('🇩🇰 +45')),
                    DropdownMenuItem(value: 'FI', child: Text('🇫🇮 +358')),
                    DropdownMenuItem(value: 'PL', child: Text('🇵🇱 +48')),
                    DropdownMenuItem(value: 'RU', child: Text('🇷🇺 +7')),
                    DropdownMenuItem(value: 'TR', child: Text('🇹🇷 +90')),
                    DropdownMenuItem(value: 'GR', child: Text('🇬🇷 +30')),
                    DropdownMenuItem(value: 'PT', child: Text('🇵🇹 +351')),
                    DropdownMenuItem(value: 'CZ', child: Text('🇨🇿 +420')),
                    DropdownMenuItem(value: 'HU', child: Text('🇭🇺 +36')),
                    DropdownMenuItem(value: 'RO', child: Text('🇷🇴 +40')),
                    DropdownMenuItem(value: 'UA', child: Text('🇺🇦 +380')),

                    // Oceania
                    DropdownMenuItem(value: 'AU', child: Text('🇦🇺 +61')),
                    DropdownMenuItem(value: 'NZ', child: Text('🇳🇿 +64')),

                    // Middle East
                    DropdownMenuItem(value: 'AE', child: Text('🇦🇪 +971')),
                    DropdownMenuItem(value: 'SA', child: Text('🇸🇦 +966')),
                    DropdownMenuItem(value: 'IL', child: Text('🇮🇱 +972')),
                    DropdownMenuItem(value: 'QA', child: Text('🇶🇦 +974')),
                    DropdownMenuItem(value: 'KW', child: Text('🇰🇼 +965')),

                    // Africa
                    DropdownMenuItem(value: 'ZA', child: Text('🇿🇦 +27')),
                    DropdownMenuItem(value: 'EG', child: Text('🇪🇬 +20')),
                    DropdownMenuItem(value: 'NG', child: Text('🇳🇬 +234')),
                    DropdownMenuItem(value: 'KE', child: Text('🇰🇪 +254')),
                  ],
                  onChanged: widget.enabled
                      ? (value) {
                          if (value != null) {
                            setState(() {
                              _selectedCountryCode = value;
                            });
                            // Re-format and validate with new country code
                            if (widget.controller.text.isNotEmpty) {
                              _formatAndValidatePhoneNumber(widget.controller.text);
                            }
                          }
                        }
                      : null,
                ),
              ),
            ),
            const SizedBox(width: 12),

            // Phone Number Input
            Expanded(
              child: TextFormField(
                controller: widget.controller,
                keyboardType: TextInputType.phone,
                enabled: widget.enabled,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  hintText: _getPhoneHint(),
                  hintStyle: const TextStyle(
                    color: Colors.white38,
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                  prefixIcon: widget.prefixIcon != null
                      ? Icon(
                          widget.prefixIcon,
                          color: Colors.white70,
                          size: 20,
                        )
                      : null,
                  filled: false,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(color: Colors.white24),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(color: Colors.white24),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(color: Colors.white70, width: 1),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(color: Colors.red, width: 1),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(color: Colors.white12),
                  ),
                  errorStyle: const TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                  errorMaxLines: 3,
                ),
                onChanged: (value) {
                  _formatAndValidatePhoneNumber(value);
                },
                validator: (value) {
                  // Custom validator first
                  if (widget.validator != null) {
                    final customError = widget.validator!(value);
                    if (customError != null) return customError;
                  }

                  // Required validation
                  if (widget.required && (value == null || value.trim().isEmpty)) {
                    return '${widget.label} is required';
                  }

                  // Phone number validation
                  if (value != null && value.trim().isNotEmpty) {
                    if (_lastValidationResult == false) {
                      return 'Invalid phone number format. Please check the example format above.';
                    }
                    if (_lastValidationResult == null) {
                      return 'Please wait while validating phone number...';
                    }
                  }

                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
            ),
          ],
        ),

        // Show formatted number hint
        if (_formattedNumber != null && _formattedNumber!.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text(
            'Formatted: $_formattedNumber',
            style: const TextStyle(
              color: Colors.white38,
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ],
    );
  }
}
