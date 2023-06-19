import 'package:geolocator/geolocator.dart';

// @ref: https://pub.dev/packages/geolocator
Future<void> requestLocationPermission() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the 
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied || 
      permission == LocationPermission.deniedForever) {
        Future.error('Location permissions are denied');
  }

  await Geolocator.requestPermission();
}

Future<Position?> getCurrentPosition() async {
  // Check permissions before doing anything
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied || 
      permission == LocationPermission.deniedForever) {
    return null;
  }
  
  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high);
}