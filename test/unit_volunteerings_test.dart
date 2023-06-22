import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_charity_app/api/ser_manos_api.dart';
import 'package:mobile_charity_app/api/ser_manos_storage.dart';
import 'package:mobile_charity_app/models/volunteering.dart';
import 'package:mobile_charity_app/providers/user_provider.dart';
import 'package:mobile_charity_app/providers/volunteering_provider.dart';

import 'mocks/mock_firebase_analytics.dart';
import 'mocks/mock_user_provider.dart';
import 'mocks/mock_volunteering_provider.dart';

void main() {
  test("get volunteering", () async {
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

  test("get volunteering by id", () async {
    // Populate the fake database.
    final fakeFirestore = FakeFirebaseFirestore();
    await fakeFirestore
        .collection('volunteerings')
        .add(MockVolunteeringProvider().volunteerings![1].toJson());
    String id = await fakeFirestore
        .collection('volunteerings')
        .add(MockVolunteeringProvider().volunteerings![0].toJson())
        .then((value) => value.id);
    await fakeFirestore
        .collection('volunteerings')
        .add(MockVolunteeringProvider().volunteerings![2].toJson());
    await fakeFirestore
        .collection('volunteerings')
        .add(MockVolunteeringProvider().volunteerings![3].toJson());

    SerManosApi().setFirestore(fakeFirestore);

    final fakeStorage = MockFirebaseStorage();
    SerManosStorage().setStorage(fakeStorage);

    VolunteeringProvider volunteeringProvider =
        VolunteeringProvider(MockUserProvider());
    await volunteeringProvider.fetchVolunteerings();
    VolunteeringModel? volunteering =
        volunteeringProvider.getVolunteeringById(id);

    assert(volunteering != null);
    expect(volunteering?.title,
        MockVolunteeringProvider().volunteerings![0].title);
    expect(volunteering?.description,
        MockVolunteeringProvider().volunteerings![0].description);
    expect(volunteering?.imageKey,
        MockVolunteeringProvider().volunteerings![0].imageKey);
  });

  test("apply to volunteering", () async {
    // Populate the fake database.
    final fakeFirestore = FakeFirebaseFirestore();
    await fakeFirestore
        .collection('volunteerings')
        .add(MockVolunteeringProvider().volunteerings![1].toJson());
    String volunteeringId = await fakeFirestore
        .collection('volunteerings')
        .add(MockVolunteeringProvider().volunteerings![0].toJson())
        .then((value) => value.id);
    await fakeFirestore
        .collection('volunteerings')
        .add(MockVolunteeringProvider().volunteerings![2].toJson());

    String userId = await fakeFirestore
        .collection('users')
        .add(MockUserProvider().user!.toJson())
        .then((value) => value.id);
    SerManosApi().setFirestore(fakeFirestore);

    final fakeStorage = MockFirebaseStorage();
    SerManosStorage().setStorage(fakeStorage);

    UserProvider userProvider = UserProvider();
    userProvider.user = MockUserProvider().user!.copyWith(id: userId);
    userProvider.setFirebaseAnalytics(MockFirebaseAnalytics());

    VolunteeringProvider volunteeringProvider =
        VolunteeringProvider(userProvider);

    await volunteeringProvider.fetchVolunteerings();
    await volunteeringProvider.applyToVolunteering(volunteeringId);

    VolunteeringModel? volunteering =
        volunteeringProvider.getVolunteeringById(volunteeringId);

    assert(volunteering != null);
    expect(volunteering!.volunteersIds.length,
        1 + MockVolunteeringProvider().volunteerings![0].volunteersIds.length);
    assert(volunteering.volunteersIds.contains(userId));
  });
}
