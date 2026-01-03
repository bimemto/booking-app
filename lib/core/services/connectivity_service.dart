import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';

/// Service to check network connectivity status
@LazySingleton()
class ConnectivityService {
  final Connectivity _connectivity;

  ConnectivityService() : _connectivity = Connectivity();

  /// Check if device has internet connection
  /// Returns true if connected to mobile data or wifi
  Future<bool> hasInternetConnection() async {
    try {
      final List<ConnectivityResult> connectivityResult =
          await _connectivity.checkConnectivity();

      // Check if any of the results indicate an active connection
      return connectivityResult.any((result) =>
          result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi ||
          result == ConnectivityResult.ethernet);
    } catch (e) {
      // If we can't check connectivity, assume no connection
      return false;
    }
  }

  /// Get connectivity status stream for real-time monitoring
  Stream<List<ConnectivityResult>> get onConnectivityChanged =>
      _connectivity.onConnectivityChanged;
}
