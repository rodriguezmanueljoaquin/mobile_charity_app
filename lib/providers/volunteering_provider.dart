import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobile_charity_app/api/ser_manos_api.dart';
import 'package:mobile_charity_app/models/user.dart';
import 'package:mobile_charity_app/models/volunteering.dart';
import 'package:mobile_charity_app/providers/user_provider.dart';
import 'package:mobile_charity_app/utils/collections.dart';
import 'package:mobile_charity_app/utils/logger.dart';

class VolunteeringProvider extends ChangeNotifier {
  UserProvider? _userProvider;
  bool isFetchingVolunteerings = false;
  bool isApplyingToVolunteering = false;
  Map<String, int>? _volunteeringsIndexById;
  List<VolunteeringModel>? _volunteerings;

  VolunteeringProvider(this._userProvider);

  VolunteeringProvider update(UserProvider userProvider) {
    _userProvider = userProvider;
    return this;
  }

  List<VolunteeringModel>? get volunteerings => _volunteerings;

  Future<void> fetchVolunteerings() async {
    isFetchingVolunteerings = true;

    try {
      List<VolunteeringModel> volunteerings =
          await SerManosApi().getVolunteerings();
      if (_userProvider!.userLocation != null) {
        // calculate distance to user location
        final List<VolunteeringModelWithDistance> volunteeringsWithDistance =
            volunteerings
                .map((volunteering) => VolunteeringModelWithDistance(
                      volunteering: volunteering,
                      target: _userProvider!.userLocation!,
                    ))
                .toList();

        volunteeringsWithDistance.sort();
        volunteerings =
            volunteeringsWithDistance.map((e) => e.volunteering).toList();
      }

      _volunteeringsIndexById = listToIndexMapByKey(volunteerings, (e) => e.id);
      _volunteerings = volunteerings;
    } catch (e) {
      rethrow;
    } finally {
      isFetchingVolunteerings = false;
      notifyListeners();
    }
  }

  VolunteeringModel? getVolunteeringById(String id) =>
      _volunteeringsIndexById?[id] != null
          ? _volunteerings![_volunteeringsIndexById![id]!]
          : null;

  List<VolunteeringModel> searchVolunteeringsByTitleAndDescription(
      String query) {
    FirebaseAnalytics.instance.logEvent(
      name: 'search_volunteerings',
      parameters: {
        'query': query,
      },
    );

    return _volunteerings!
        .where((element) =>
            element.title.toLowerCase().contains(query.toLowerCase()) ||
            element.description.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  Future<void> applyToVolunteering(String volunteeringId) async {
    try {
      isApplyingToVolunteering = true;

      await SerManosApi().applyToVolunteering(
        userId: _userProvider!.user!.id,
        volunteeringId: volunteeringId,
      );

      FirebaseAnalytics.instance.logEvent(
        name: 'apply_to_volunteering',
        parameters: {
          'volunteering_id': volunteeringId,
        },
      );

      // refetch user and volunteerings
      await fetchVolunteerings();
      await _userProvider!.fetchUser();
    } catch (e) {
      // TODO: handle error
      logger.e(e);
    } finally {
      isApplyingToVolunteering = false;
    }
  }

  Future<void> fetchVolunteeringById(String volunteeringId) async {
    VolunteeringModel? volunteering =
        await SerManosApi().getVolunteeringById(volunteeringId: volunteeringId);

    if (volunteering == null) {
      throw Exception('Volunteering not found');
    }

    // add or update volunteering
    if (_volunteeringsIndexById?[volunteeringId] == null) {
      // TODO: sort by distance
      _volunteerings!.add(volunteering);
      _volunteeringsIndexById?[volunteeringId] = _volunteerings!.length - 1;
    } else {
      _volunteerings![_volunteeringsIndexById![volunteeringId]!] = volunteering;
    }

    notifyListeners();
  }

  Future<void> abandonCurrentVolunteering() async {
    try {
      isApplyingToVolunteering = true;

      UserModel user = _userProvider!.user!;

      if (user.currentVolunteeringId == null) {
        throw Exception('User has no current volunteering ID');
      }

      await SerManosApi().abandonVolunteering(
        userId: user.id,
        volunteeringId: user.currentVolunteeringId!,
      );

      FirebaseAnalytics.instance.logEvent(
        name: 'abandon_volunteering',
        parameters: {
          'volunteering_id': user.currentVolunteeringId!,
        },
      );

      // refetch user and volunteerings
      await fetchVolunteerings();
      await _userProvider!.fetchUser();
    } catch (e) {
      logger.e(e);
      rethrow;
    } finally {
      isApplyingToVolunteering = false;
    }
  }
}

class VolunteeringModelWithDistance
    implements Comparable<VolunteeringModelWithDistance> {
  final VolunteeringModel volunteering;
  late final double distance;

  VolunteeringModelWithDistance(
      {required this.volunteering, required GeoPoint target}) {
    distance = Geolocator.distanceBetween(target.latitude, target.longitude,
        volunteering.location.latitude, volunteering.location.longitude);
  }

  @override
  int compareTo(VolunteeringModelWithDistance other) {
    return distance.compareTo(other.distance);
  }
}
