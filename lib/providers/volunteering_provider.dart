import 'package:flutter/foundation.dart';
import 'package:mobile_charity_app/api/ser_manos_api.dart';
import 'package:mobile_charity_app/models/volunteering.dart';
import 'package:mobile_charity_app/providers/user_provider.dart';

class VolunteeringProvider extends ChangeNotifier {
  final UserProvider? _userProvider;
  bool isLoading = false;
  Map<String, VolunteeringModel> _volunteeringsMap = {};

  VolunteeringProvider(this._userProvider);

  Future<void> fetchVolunteerings() async {
    isLoading = true;

    try {
      List<VolunteeringModel> volunteerings =
          await SerManosApi().getVolunteerings();
      if (_userProvider!.userLocation != null) {
        // volunteerings.sort((a, b) => a.distance!.compareTo(b.distance!));
        print('volunteerings: ${volunteerings.length}');
      }
      _volunteeringsMap =
          volunteerings.asMap().map((key, value) => MapEntry(value.id, value));
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Map<String, VolunteeringModel> get volunteeringsMap => _volunteeringsMap;

  VolunteeringModel? getVolunteeringById(String id) => _volunteeringsMap[id];
  VolunteeringModel getVolunteeringByIndex(int index) =>
      _volunteeringsMap.values.toList()[index];


  List<VolunteeringModel> searchVolunteeringsByTitle(String query) {
    return _volunteeringsMap.values
        .where((element) =>
            element.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
