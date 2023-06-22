import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:mobile_charity_app/models/user.dart';
import 'package:mobile_charity_app/utils/logger.dart';

Future<void> setAnalyticsUserId(UserModel? user) async {
  await FirebaseAnalytics.instance.setUserId(id: user?.id);
  try {
    await FirebaseCrashlytics.instance.setUserIdentifier(user?.id ?? '');
  } catch (e) {
    logger.e(e);
  }
}
