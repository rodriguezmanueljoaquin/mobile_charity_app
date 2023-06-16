import 'package:mobile_charity_app/models/volunteering.dart';
import 'package:collection/collection.dart';
import 'package:mobile_charity_app/providers/user_provider.dart';

class VolunteeringProvider {
  final UserProvider _userProvider;
  List<VolunteeringModel> _volunteerings = [];

  VolunteeringProvider(this._userProvider);

  List<VolunteeringModel> get volunteerings => _volunteerings;

  set volunteerings(List<VolunteeringModel> volunteerings) {
    if (_userProvider.userLocation != null) {
      // volunteerings.sort((a, b) => a.distance!.compareTo(b.distance!));
      print('volunteerings: ${volunteerings.length}');
    }
    _volunteerings = volunteerings;
  }

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
