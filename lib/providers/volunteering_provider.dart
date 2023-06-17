import 'package:flutter/foundation.dart';
import 'package:mobile_charity_app/api/ser_manos_api.dart';
import 'package:mobile_charity_app/models/volunteering.dart';
import 'package:mobile_charity_app/providers/user_provider.dart';
import 'package:mobile_charity_app/utils/collections.dart';

class VolunteeringProvider extends ChangeNotifier {
  final UserProvider? _userProvider;
  bool isLoading = false;
  Map<String, int> _volunteeringsIndexById = {};
  List<VolunteeringModel> _volunteerings = [];

  VolunteeringProvider(this._userProvider);

  List<VolunteeringModel> get volunteerings => _volunteerings;

  Future<void> fetchVolunteerings() async {
    isLoading = true;

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
      isLoading = false;
      notifyListeners();
    }
  }

  VolunteeringModel? getVolunteeringById(String id) =>
      _volunteeringsIndexById[id] != null
          ? _volunteerings[_volunteeringsIndexById[id]!]
          : null;

  List<VolunteeringModel> searchVolunteeringsByTitle(String query) {
    return _volunteerings
        .where((element) =>
            element.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
