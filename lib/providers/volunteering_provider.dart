import 'package:flutter/foundation.dart';
import 'package:mobile_charity_app/api/ser_manos_api.dart';
import 'package:mobile_charity_app/models/volunteering.dart';
import 'package:collection/collection.dart';
import 'package:mobile_charity_app/providers/user_provider.dart';

class VolunteeringProvider extends ChangeNotifier {
  final UserProvider? _userProvider;
  bool isLoading = false;
  List<VolunteeringModel> _volunteerings = [];

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
      _volunteerings = volunteerings;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  List<VolunteeringModel> get volunteerings => _volunteerings;

  VolunteeringModel? getVolunteeringById(String id) {
    return _volunteerings.firstWhereOrNull((element) => element.id == id);
  }

  List<VolunteeringModel> searchVolunteeringsByTitle(String query) {
    return _volunteerings
        .where((element) =>
            element.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
