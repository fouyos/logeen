import 'package:awas/domain/core/analytics.dart';
import 'package:awas/domain/core/locator.dart';
import 'package:awas/domain/core/logger.dart';
import 'package:awas/domain/core/router.dart';
import 'package:awas/presentation/core/custom_theme.dart';
import 'package:catcher/core/catcher.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class AwasApp extends StatelessWidget {
  @override
  Widget build(
    BuildContext context,
  ) {
    /// The method is asynchronous and returns a Future,
    /// so you need to ensure it has completed before displaying
    /// your main application.
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          /// Use Neumorphic design language.
          return NeumorphicApp(
            /// This navigatorKey will be used to navigate user
            /// to report page or to show dialog.
            navigatorKey: Catcher.navigatorKey,
            navigatorObservers: [
              locator<AnalyticsService>().analyticsObserver(),
            ],
            title: 'AWAS',
            theme: CustomTheme.light,
            themeMode: ThemeMode.light,
            initialRoute: '/authentication',
            onGenerateRoute: Routes.router.generator,
            builder: (
              BuildContext context,
              Widget widget,
            ) {
              return Catcher.addDefaultErrorWidget();
            },
          );
        } else if (snapshot.hasError) {
          logger.e(
            snapshot.error,
          );

          return null;
        }

        return CircularProgressIndicator();
      },
    );
  }
}
