import 'package:flutter/foundation.dart';
import 'package:mobile_charity_app/api/ser_manos_api.dart';
import 'package:mobile_charity_app/models/user.dart';
import 'package:mobile_charity_app/models/volunteering.dart';
import 'package:mobile_charity_app/providers/user_provider.dart';
import 'package:mobile_charity_app/utils/collections.dart';

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
        // volunteerings.sort((a, b) => a.distance!.compareTo(b.distance!));
        print('volunteerings: ${volunteerings.length}');
      }
      _volunteeringsIndexById = listToIndexMapByKey(volunteerings, (e) => e.id);
      _volunteerings = volunteerings;
    } finally {
      isFetchingVolunteerings = false;
      notifyListeners();
    }
  }

  VolunteeringModel? getVolunteeringById(String id) =>
      _volunteeringsIndexById?[id] != null
          ? _volunteerings![_volunteeringsIndexById![id]!]
          : null;

  List<VolunteeringModel> searchVolunteeringsByTitle(String query) {
    return _volunteerings!
        .where((element) =>
            element.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  Future<void> applyToVolunteering(String volunteeringId) async {
    try {
      isApplyingToVolunteering = true;

      await SerManosApi().applyToVolunteering(
        userId: _userProvider!.user!.id,
        volunteeringId: volunteeringId,
      );

      // refetch user and volunteerings
      await fetchVolunteerings();
      await _userProvider!.fetchUser();
    } catch (e) {
      // TODO: handle error
      print(e);
    } finally {
      isApplyingToVolunteering = false;
    }
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

      // refetch user and volunteerings
      await fetchVolunteerings();
      await _userProvider!.fetchUser();
    } catch (e) {
      // TODO: handle error
      print(e);
    } finally {
      isApplyingToVolunteering = false;
    }
  }
}
