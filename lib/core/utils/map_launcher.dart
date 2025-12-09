import 'package:url_launcher/url_launcher.dart';
import 'dart:io';

/// Utility class to launch navigation apps
class MapLauncher {
  /// Open address in Maps app (Google Maps on Android, Apple Maps on iOS)
  static Future<bool> openAddress(String address) async {
    if (address.isEmpty) return false;

    try {
      final encodedAddress = Uri.encodeComponent(address);
      final Uri url;

      if (Platform.isIOS) {
        // Apple Maps on iOS
        url = Uri.parse('http://maps.apple.com/?q=$encodedAddress');
      } else {
        // Google Maps on Android and other platforms
        url = Uri.parse('https://www.google.com/maps/search/?api=1&query=$encodedAddress');
      }

      if (await canLaunchUrl(url)) {
        return await launchUrl(url, mode: LaunchMode.externalApplication);
      }
      return false;
    } catch (e) {
      print('Error opening maps: $e');
      return false;
    }
  }

  /// Open coordinates in Maps app
  static Future<bool> openCoordinates(double latitude, double longitude) async {
    try {
      final Uri url;

      if (Platform.isIOS) {
        // Apple Maps on iOS
        url = Uri.parse('http://maps.apple.com/?ll=$latitude,$longitude');
      } else {
        // Google Maps on Android and other platforms
        url = Uri.parse('https://www.google.com/maps/search/?api=1&query=$latitude,$longitude');
      }

      if (await canLaunchUrl(url)) {
        return await launchUrl(url, mode: LaunchMode.externalApplication);
      }
      return false;
    } catch (e) {
      print('Error opening maps: $e');
      return false;
    }
  }

  /// Open navigation to address
  static Future<bool> navigateToAddress(String address) async {
    if (address.isEmpty) return false;

    try {
      final encodedAddress = Uri.encodeComponent(address);
      final Uri url;

      if (Platform.isIOS) {
        // Apple Maps navigation on iOS
        url = Uri.parse('http://maps.apple.com/?daddr=$encodedAddress&dirflg=d');
      } else {
        // Google Maps navigation on Android
        url = Uri.parse('https://www.google.com/maps/dir/?api=1&destination=$encodedAddress');
      }

      if (await canLaunchUrl(url)) {
        return await launchUrl(url, mode: LaunchMode.externalApplication);
      }
      return false;
    } catch (e) {
      print('Error opening navigation: $e');
      return false;
    }
  }
}
