import 'package:awas/infrastructure/authentication/repositories/authentication_repository.dart';
import 'package:awas/presentation/authentication/authentication_screen.dart';
import 'package:awas/presentation/device/device_screen.dart';
import 'package:awas/presentation/login/login_screen.dart';
import 'package:fluro/fluro.dart';

// ignore: avoid_classes_with_only_static_members
class Routes {
  /// Ignore this from linter because [Router] need to be static.
  static Router router = Router();

  /// Setup [Router]. Every routes must be defined here.
  static void setup() {
    /// The '..' syntax is a Dart feature called cascade notation.
    /// Further reading:
    /// https://dart.dev/guides/language/language-tour#cascade-notation-
    router
      ..define(
        /// The '/' route name is the default to as our initial one.
        '/authentication',
        transitionType: TransitionType.fadeIn,
        handler: Handler(
          handlerFunc: (
            context,
            params,
          ) {
            return AuthenticationScreen(
              repository: AuthenticationRepository(),
            );
          },
        ),
      )
      ..define(
        '/login',
        transitionType: TransitionType.material,
        handler: Handler(
          handlerFunc: (
            context,
            params,
          ) {
            return LoginScreen();
          },
        ),
      )
      ..define(
        '/device',
        transitionType: TransitionType.material,
        handler: Handler(
          handlerFunc: (
            context,
            params,
          ) {
            return DeviceScreen();
          },
        ),
      );
  }
}
