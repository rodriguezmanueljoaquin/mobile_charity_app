import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_charity_app/api/ser_manos_api.dart';
import 'package:mobile_charity_app/api/ser_manos_storage.dart';
import 'package:mobile_charity_app/models/volunteering.dart';
import 'package:mobile_charity_app/providers/volunteering_provider.dart';

import 'mocks/mock_user_provider.dart';
import 'mocks/mock_volunteering_provider.dart';

void main() {
  testWidgets("get volunteering", (WidgetTester tester) async {
    // Populate the fake database.
    final fakeFirestore = FakeFirebaseFirestore();
    await fakeFirestore
        .collection('volunteerings')
        .add(MockVolunteeringProvider().volunteerings![0].toJson());

    SerManosApi().setFirestore(fakeFirestore);

    final fakeStorage = MockFirebaseStorage();
    SerManosStorage().setStorage(fakeStorage);

    VolunteeringProvider volunteeringProvider =
        VolunteeringProvider(MockUserProvider());
    await volunteeringProvider.fetchVolunteerings();
    List<VolunteeringModel>? volunteerings = volunteeringProvider.volunteerings;

    assert(volunteerings != null);
    assert(volunteerings!.length == 1);
    // test are not equal because its created on firestore add
    expect(volunteerings![0].title,
        MockVolunteeringProvider().volunteerings![0].title);
    expect(volunteerings[0].description,
        MockVolunteeringProvider().volunteerings![0].description);
    expect(volunteerings[0].imageKey,
        MockVolunteeringProvider().volunteerings![0].imageKey);
  });
}
