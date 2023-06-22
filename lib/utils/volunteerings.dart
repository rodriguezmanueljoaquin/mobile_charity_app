import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_charity_app/models/volunteering.dart';
import 'package:mobile_charity_app/utils/geolocator.dart';

List<VolunteeringModel> sortVolunteeringsByDistanceToUser(
    List<VolunteeringModel> volunteerings, GeoPoint userLocation) {
  volunteerings.sort((a, b) =>
      distanceBetweenGeoPoints(userLocation, a.location)
          .compareTo(distanceBetweenGeoPoints(userLocation, b.location)));

  return volunteerings;
}
