import 'package:awas/domain/core/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Observe every [Bloc](business logic) changes.
class AwasBlocObserver extends BlocObserver {
  @override
  void onChange(
    Cubit cubit,
    Change change,
  ) {
    logger.d(
      '${cubit.runtimeType} $change',
    );

    super.onChange(
      cubit,
      change,
    );
  }
}
