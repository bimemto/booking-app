import 'package:dropdown_button2/dropdown_button2.dart';
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

  static const List<Map<String, String>> countryList = [
    {'code': 'VN', 'flag': '🇻🇳', 'dial': '+84'},
    {'code': 'CN', 'flag': '🇨🇳', 'dial': '+86'},
    {'code': 'JP', 'flag': '🇯🇵', 'dial': '+81'},
    {'code': 'KR', 'flag': '🇰🇷', 'dial': '+82'},
    {'code': 'SG', 'flag': '🇸🇬', 'dial': '+65'},
    {'code': 'TH', 'flag': '🇹🇭', 'dial': '+66'},
    {'code': 'MY', 'flag': '🇲🇾', 'dial': '+60'},
    {'code': 'ID', 'flag': '🇮🇩', 'dial': '+62'},
    {'code': 'PH', 'flag': '🇵🇭', 'dial': '+63'},
    {'code': 'IN', 'flag': '🇮🇳', 'dial': '+91'},
    {'code': 'HK', 'flag': '🇭🇰', 'dial': '+852'},
    {'code': 'TW', 'flag': '🇹🇼', 'dial': '+886'},
    {'code': 'BD', 'flag': '🇧🇩', 'dial': '+880'},
    {'code': 'PK', 'flag': '🇵🇰', 'dial': '+92'},
    {'code': 'LK', 'flag': '🇱🇰', 'dial': '+94'},
    {'code': 'MM', 'flag': '🇲🇲', 'dial': '+95'},
    {'code': 'KH', 'flag': '🇰🇭', 'dial': '+855'},
    {'code': 'LA', 'flag': '🇱🇦', 'dial': '+856'},
    {'code': 'MN', 'flag': '🇲🇳', 'dial': '+976'},
    {'code': 'US', 'flag': '🇺🇸', 'dial': '+1'},
    {'code': 'CA', 'flag': '🇨🇦', 'dial': '+1'},
    {'code': 'MX', 'flag': '🇲🇽', 'dial': '+52'},
    {'code': 'BR', 'flag': '🇧🇷', 'dial': '+55'},
    {'code': 'AR', 'flag': '🇦🇷', 'dial': '+54'},
    {'code': 'CL', 'flag': '🇨🇱', 'dial': '+56'},
    {'code': 'CO', 'flag': '🇨🇴', 'dial': '+57'},
    {'code': 'PE', 'flag': '🇵🇪', 'dial': '+51'},
    {'code': 'GB', 'flag': '🇬🇧', 'dial': '+44'},
    {'code': 'FR', 'flag': '🇫🇷', 'dial': '+33'},
    {'code': 'DE', 'flag': '🇩🇪', 'dial': '+49'},
    {'code': 'IT', 'flag': '🇮🇹', 'dial': '+39'},
    {'code': 'ES', 'flag': '🇪🇸', 'dial': '+34'},
    {'code': 'NL', 'flag': '🇳🇱', 'dial': '+31'},
    {'code': 'BE', 'flag': '🇧🇪', 'dial': '+32'},
    {'code': 'CH', 'flag': '🇨🇭', 'dial': '+41'},
    {'code': 'AT', 'flag': '🇦🇹', 'dial': '+43'},
    {'code': 'SE', 'flag': '🇸🇪', 'dial': '+46'},
    {'code': 'NO', 'flag': '🇳🇴', 'dial': '+47'},
    {'code': 'DK', 'flag': '🇩🇰', 'dial': '+45'},
    {'code': 'FI', 'flag': '🇫🇮', 'dial': '+358'},
    {'code': 'PL', 'flag': '🇵🇱', 'dial': '+48'},
    {'code': 'RU', 'flag': '🇷🇺', 'dial': '+7'},
    {'code': 'TR', 'flag': '🇹🇷', 'dial': '+90'},
    {'code': 'GR', 'flag': '🇬🇷', 'dial': '+30'},
    {'code': 'PT', 'flag': '🇵🇹', 'dial': '+351'},
    {'code': 'CZ', 'flag': '🇨🇿', 'dial': '+420'},
    {'code': 'HU', 'flag': '🇭🇺', 'dial': '+36'},
    {'code': 'RO', 'flag': '🇷🇴', 'dial': '+40'},
    {'code': 'UA', 'flag': '🇺🇦', 'dial': '+380'},
    {'code': 'AU', 'flag': '🇦🇺', 'dial': '+61'},
    {'code': 'NZ', 'flag': '🇳🇿', 'dial': '+64'},
    {'code': 'AE', 'flag': '🇦🇪', 'dial': '+971'},
    {'code': 'SA', 'flag': '🇸🇦', 'dial': '+966'},
    {'code': 'IL', 'flag': '🇮🇱', 'dial': '+972'},
    {'code': 'QA', 'flag': '🇶🇦', 'dial': '+974'},
    {'code': 'KW', 'flag': '🇰🇼', 'dial': '+965'},
    {'code': 'ZA', 'flag': '🇿🇦', 'dial': '+27'},
    {'code': 'EG', 'flag': '🇪🇬', 'dial': '+20'},
    {'code': 'NG', 'flag': '🇳🇬', 'dial': '+234'},
    {'code': 'KE', 'flag': '🇰🇪', 'dial': '+254'},
  ];

  @override
  State<LabeledPhoneField> createState() => _LabeledPhoneFieldState();
}

class _LabeledPhoneFieldState extends State<LabeledPhoneField> {
  late String _selectedCountryCode;
  String? _formattedNumber;
  String? _e164Number; // Store E.164 format for API submission
  bool _isInitialized = false;
  bool? _lastValidationResult;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedCountryCode = widget.initialCountryCode ?? 'VN';

    // If controller has existing E.164 number, try to detect country
    if (widget.controller.text.startsWith('+')) {
      _detectCountryFromE164(widget.controller.text);
    }

    _initializeLibPhoneNumber();

    // Add listener to validate existing phone number after initialization
    widget.controller.addListener(_validateExistingNumber);
  }

  void _detectCountryFromE164(String e164Number) {
    // Simple country code detection from E.164 format
    if (e164Number.startsWith('+84')) {
      _selectedCountryCode = 'VN';
    } else if (e164Number.startsWith('+1')) {
      _selectedCountryCode = 'US'; // Could be US or CA
    } else if (e164Number.startsWith('+86')) {
      _selectedCountryCode = 'CN';
    } else if (e164Number.startsWith('+81')) {
      _selectedCountryCode = 'JP';
    } else if (e164Number.startsWith('+82')) {
      _selectedCountryCode = 'KR';
    } else if (e164Number.startsWith('+65')) {
      _selectedCountryCode = 'SG';
    } else if (e164Number.startsWith('+66')) {
      _selectedCountryCode = 'TH';
    } else if (e164Number.startsWith('+44')) {
      _selectedCountryCode = 'GB';
    }
    // Add more as needed, or default to initialCountryCode
  }

  void _validateExistingNumber() {
    // Only validate once after initialization and if there's existing text
    if (_isInitialized && widget.controller.text.isNotEmpty && _lastValidationResult == null) {
      _formatAndValidatePhoneNumber(widget.controller.text);
      // Remove listener after first validation
      widget.controller.removeListener(_validateExistingNumber);
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_validateExistingNumber);
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _initializeLibPhoneNumber() async {
    try {
      await init();
      setState(() {
        _isInitialized = true;
      });

      // Validate and convert existing E.164 number to local format
      if (widget.controller.text.isNotEmpty) {
        await _formatAndValidatePhoneNumber(widget.controller.text);

        // If it's E.164 format, convert to national format for display
        if (widget.controller.text.startsWith('+')) {
          try {
            final result = await parse(widget.controller.text, region: _selectedCountryCode);
            final nationalFormat = result['national'] as String?;
            if (nationalFormat != null) {
              // Update controller with national format for easier editing
              widget.controller.text = nationalFormat;
            }
          } catch (e) {
            debugPrint('Error converting E.164 to national format: $e');
          }
        }
      }
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
                child: DropdownButton2<String>(
                  isExpanded: true,
                  hint: Text(
                    'Select Country',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  items: LabeledPhoneField.countryList
                      .map((item) => DropdownMenuItem<String>(
                            value: item['code'],
                            child: Text(
                              '${item['flag']} ${item['dial']}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ))
                      .toList(),
                  value: _selectedCountryCode,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedCountryCode = value;
                      });
                      // Re-format and validate with new country code
                      if (widget.controller.text.isNotEmpty) {
                        _formatAndValidatePhoneNumber(widget.controller.text);
                      }
                    }
                  },
                  buttonStyleData: const ButtonStyleData(
                    height: 56,
                    width: 120,
                    padding: EdgeInsets.only(left: 8, right: 8),
                  ),
                  iconStyleData: const IconStyleData(
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white70,
                    ),
                    iconSize: 24,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    maxHeight: 400,
                    width: 300, // Make dropdown wider for search visibility
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey[900],
                    ),
                    scrollbarTheme: ScrollbarThemeData(
                      radius: const Radius.circular(40),
                      thickness: MaterialStateProperty.all(6),
                      thumbVisibility: MaterialStateProperty.all(true),
                    ),
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    height: 48,
                    padding: EdgeInsets.only(left: 14, right: 14),
                  ),
                  dropdownSearchData: DropdownSearchData(
                    searchController: _searchController,
                    searchInnerWidgetHeight: 50,
                    searchInnerWidget: Container(
                      height: 50,
                      padding: const EdgeInsets.only(
                        top: 8,
                        bottom: 4,
                        right: 8,
                        left: 8,
                      ),
                      child: TextFormField(
                        expands: true,
                        maxLines: null,
                        controller: _searchController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 8,
                          ),
                          hintText: 'Search country code...',
                          hintStyle: const TextStyle(fontSize: 12, color: Colors.white38),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Colors.white24),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Colors.white24),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Colors.white70),
                          ),
                        ),
                      ),
                    ),
                    searchMatchFn: (item, searchValue) {
                      final country = LabeledPhoneField.countryList.firstWhere(
                        (c) => c['code'] == item.value,
                        orElse: () => {'code': '', 'dial': '', 'flag': ''},
                      );
                      
                      final searchLower = searchValue.toLowerCase();
                      final code = country['code']?.toLowerCase() ?? '';
                      final dial = country['dial']?.toLowerCase() ?? '';
                      
                      return code.contains(searchLower) || dial.contains(searchLower);
                    },
                  ),
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
