import 'package:awas/domain/core/catcher.dart';
import 'package:awas/domain/core/locator.dart';
import 'package:awas/domain/core/observer.dart';
import 'package:awas/domain/core/router.dart';
import 'package:awas/presentation/app.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  /// Some needed-to-run initialization.
  if (kDebugMode) {
    /// Only run this block below on debug mode.
    EquatableConfig.stringify = true;
    Bloc.observer = AwasBlocObserver();
  }
  Routes.setup();
  Catches.setup();
  Locates.setup();

  runApp(
    AwasApp(),
  );
}
