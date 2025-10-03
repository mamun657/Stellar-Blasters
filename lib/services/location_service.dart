import 'package:geolocator/geolocator.dart';

class LocationService {
  /// Fetch the current location of the device
  /// Returns a Future<Position> with latitude and longitude
  /// Throws LocationServiceException if there's any error
  static Future<Position> getCurrentLocation() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw LocationServiceException('Location services are disabled');
      }

      // Check for location permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw LocationServiceException('Location permissions are denied');
        }
      }

      // Check if permissions are permanently denied
      if (permission == LocationPermission.deniedForever) {
        throw LocationServiceException(
          'Location permissions are permanently denied, cannot request permissions.',
        );
      }

      // Get the current position
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
        timeLimit: const Duration(seconds: 10),
      );

      return position;
    } catch (e) {
      throw LocationServiceException(
        'Error getting location: ${e.toString()}',
      );
    }
  }
}

/// Custom exception for location service related errors
class LocationServiceException implements Exception {
  final String message;
  LocationServiceException(this.message);

  @override
  String toString() => 'LocationServiceException: $message';
}

// Example usage:
/*
void example() async {
  try {
    Position position = await LocationService.getCurrentLocation();
    print('Latitude: ${position.latitude}');
    print('Longitude: ${position.longitude}');
  } on LocationServiceException catch (e) {
    print('Location error: ${e.message}');
  } catch (e) {
    print('Unexpected error: $e');
  }
}
*/