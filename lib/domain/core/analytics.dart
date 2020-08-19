import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

class AnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics();

  /// Return an AnalyticsObserver which will be used to track routes.
  FirebaseAnalyticsObserver analyticsObserver() {
    return FirebaseAnalyticsObserver(
      analytics: _analytics,
    );
  }
}
