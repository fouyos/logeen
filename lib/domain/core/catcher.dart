import 'package:awas/presentation/app.dart';
import 'package:catcher/catcher.dart';

/// Configure [Catcher] to catch error and gave the report to Developers.
class Catches {
  static void setup() {
    final CatcherOptions debugOptions = CatcherOptions(
      SilentReportMode(),
      [
        ConsoleHandler(
          enableDeviceParameters: false,
          enableApplicationParameters: false,
        )
      ],
    );
    final CatcherOptions releaseOptions = CatcherOptions(
      DialogReportMode(),
      [
        EmailManualHandler(
          [
            /// TODO change this email address where error need to be sent to.
            'support@example.com',
          ],
          emailTitle: 'AWAS Crash Report',
          emailHeader: 'Attached Below',
          printLogs: true,
        )
      ],
    );
    Catcher(
      AwasApp(),
      debugConfig: debugOptions,
      releaseConfig: releaseOptions,
    );
  }
}
