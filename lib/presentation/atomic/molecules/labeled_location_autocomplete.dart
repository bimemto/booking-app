import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import '../../../core/theme/app_text_styles.dart';

/// Simple location data class
class LocationSuggestion {
  final String displayName;
  final double? lat;
  final double? lon;

  LocationSuggestion({
    required this.displayName,
    this.lat,
    this.lon,
  });

  factory LocationSuggestion.fromJson(Map<String, dynamic> json) {
    return LocationSuggestion(
      displayName: json['display_name'] as String,
      lat: double.tryParse(json['lat']?.toString() ?? ''),
      lon: double.tryParse(json['lon']?.toString() ?? ''),
    );
  }
}

/// Molecule: Labeled Location Autocomplete Field
/// Location search with Nominatim (OpenStreetMap) autocomplete
class LabeledLocationAutocomplete extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final String? hintText;
  final IconData? prefixIcon;
  final bool required;
  final bool enabled;
  final String? Function(String?)? validator;
  final Function(LocationSuggestion?)? onPlaceSelected;

  const LabeledLocationAutocomplete({
    super.key,
    required this.label,
    required this.controller,
    this.hintText,
    this.prefixIcon,
    this.required = false,
    this.enabled = true,
    this.validator,
    this.onPlaceSelected,
  });

  @override
  State<LabeledLocationAutocomplete> createState() =>
      _LabeledLocationAutocompleteState();
}

class _LabeledLocationAutocompleteState
    extends State<LabeledLocationAutocomplete> {
  final Dio _dio = Dio();
  List<LocationSuggestion> _suggestions = [];
  bool _isSearching = false;
  String _lastQuery = '';
  Timer? _debounceTimer;

  void _searchLocation(String query) {
    // Cancel previous timer
    _debounceTimer?.cancel();

    if (query.isEmpty || query.length < 3) {
      setState(() {
        _suggestions = [];
        _isSearching = false;
      });
      return;
    }

    // Show loading indicator immediately
    setState(() {
      _isSearching = true;
    });

    // Create new debounce timer (500ms delay)
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      _performSearch(query);
    });
  }

  Future<void> _performSearch(String query) async {
    // Avoid duplicate searches
    if (query == _lastQuery) {
      setState(() {
        _isSearching = false;
      });
      return;
    }
    _lastQuery = query;

    try {
      final response = await _dio.get(
        'https://nominatim.openstreetmap.org/search',
        queryParameters: {
          'q': query,
          'format': 'json',
          'limit': 5,
          'addressdetails': 1,
        },
        options: Options(
          headers: {
            'User-Agent': 'BookingDemoApp/1.0',
          },
        ),
      );

      if (mounted && response.data is List) {
        final results = (response.data as List)
            .map((json) => LocationSuggestion.fromJson(json))
            .toList();

        setState(() {
          _suggestions = results;
          _isSearching = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _suggestions = [];
          _isSearching = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _onPlaceSelected(LocationSuggestion place) {
    setState(() {
      widget.controller.text = place.displayName;
      _suggestions = [];
    });
    widget.onPlaceSelected?.call(place);
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
              style: AppTextStyles.bodySmall.copyWith(
                color: Colors.white70,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (widget.required)
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

        // Text Field with Autocomplete
        TextFormField(
          controller: widget.controller,
          enabled: widget.enabled,
          style: const TextStyle(color: Colors.white, fontSize: 16),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: const TextStyle(color: Colors.white38),
            prefixIcon: widget.prefixIcon != null
                ? Icon(widget.prefixIcon, color: Colors.white70, size: 20)
                : null,
            suffixIcon: _isSearching
                ? const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white70,
                      ),
                    ),
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
          validator: widget.validator,
          onChanged: _searchLocation,
          maxLines: 2,
          minLines: 1,
        ),

        // Suggestions List
        if (_suggestions.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white24, width: 1),
            ),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _suggestions.length,
              separatorBuilder: (context, index) => const Divider(
                color: Colors.white12,
                height: 1,
              ),
              itemBuilder: (context, index) {
                final place = _suggestions[index];
                return ListTile(
                  leading: const Icon(
                    Icons.location_on,
                    color: Colors.white70,
                    size: 20,
                  ),
                  title: Text(
                    place.displayName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () => _onPlaceSelected(place),
                  dense: true,
                );
              },
            ),
          ),
      ],
    );
  }
}
