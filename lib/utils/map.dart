import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:mobile_charity_app/models/volunteering.dart';
import 'package:mobile_charity_app/utils/logger.dart';

Future<void> showVolunteeringMap(VolunteeringModel volunteering) async {
  final availableMaps = await MapLauncher.installedMaps;

  logger.d("Available maps", availableMaps);

  final geoPoint = volunteering.location;
  final coords = Coords(geoPoint.latitude, geoPoint.longitude);
  bool hasGoogleMaps =
      availableMaps.any((map) => map.mapType == MapType.google);

  await MapLauncher.showMarker(
      mapType: hasGoogleMaps ? MapType.google : availableMaps.first.mapType,
      coords: coords,
      title: volunteering.address);
}
