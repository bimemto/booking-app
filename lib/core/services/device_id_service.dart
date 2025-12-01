import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

/// Service for managing unique device identifier
/// Generates and persists a unique device ID for tracking user bookings
@lazySingleton
class DeviceIdService {
  static const String _deviceIdKey = 'device_id';
  final SharedPreferences _prefs;
  final Uuid _uuid = const Uuid();

  DeviceIdService(this._prefs);

  /// Get or create device ID
  /// Returns a persistent unique identifier for this device
  Future<String> getDeviceId() async {
    // Check if device ID already exists
    String? deviceId = _prefs.getString(_deviceIdKey);

    if (deviceId == null || deviceId.isEmpty) {
      // Generate new UUID v4
      deviceId = _uuid.v4();

      // Save to shared preferences
      await _prefs.setString(_deviceIdKey, deviceId);
    }

    return deviceId;
  }

  /// Clear device ID (for testing purposes)
  Future<void> clearDeviceId() async {
    await _prefs.remove(_deviceIdKey);
  }
}
