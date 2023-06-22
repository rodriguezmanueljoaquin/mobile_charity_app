import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:mockito/mockito.dart';

class MockFirebaseAnalytics extends Mock implements FirebaseAnalytics {
  @override
  Future<void> logEvent({
    required String name,
    Map<String, Object?>? parameters,
    AnalyticsCallOptions? callOptions,
  }) {
    return Future.value();
  }
}
