import 'package:awas/domain/core/analytics.dart';
import 'package:get_it/get_it.dart';

/// Initialize global [locator].
GetIt locator = GetIt.instance;

/// Setup [GetIt.instance] locator.
class Locates {
  static void setup() {
    locator.registerLazySingleton(
      () => AnalyticsService(),
    );
  }
}
