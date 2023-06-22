import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
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

  LocationPermission newPermission = await Geolocator.requestPermission();

  switch (newPermission) {
    case LocationPermission.denied:
    case LocationPermission.deniedForever:
      FirebaseAnalytics.instance.logEvent(name: "location_permission_denied");
      Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
      break;
    case LocationPermission.whileInUse:
    case LocationPermission.always:
      FirebaseAnalytics.instance.logEvent(name: "location_permission_granted");
      break;
    default:
      break;
  }
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

double distanceBetweenGeoPoints(GeoPoint p1, GeoPoint p2) {
  return Geolocator.distanceBetween(
      p1.latitude, p1.longitude, p2.latitude, p2.longitude);
}
