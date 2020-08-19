import 'dart:async';

import 'package:awas/domain/authentication/models/authentication_user_model.dart';
import 'package:awas/infrastructure/authentication/repositories/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:pedantic/pedantic.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

/// A business logic to check whether user has authenticated or needed to.
///
/// [AuthenticationEvent] and [AuthenticationState] are part of this.
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    @required AuthenticationRepository repository,
  })  : assert(
          repository != null,
        ),
        _repository = repository,
        super(
          const AuthenticationState.unknown(),
        ) {
    _subscription = _repository.user.listen(
      (
        user,
      ) {
        add(
          AuthenticationUserChanged(
            user,
          ),
        );
      },
    );
  }

  final AuthenticationRepository _repository;
  StreamSubscription<AuthenticationUserModel> _subscription;

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationUserChanged) {
      yield _mapAuthenticationUserChangedToState(
        event,
      );
    } else if (event is AuthenticationLogoutRequested) {
      unawaited(
        _repository.logOut(),
      );
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();

    return super.close();
  }

  AuthenticationState _mapAuthenticationUserChangedToState(
    AuthenticationUserChanged event,
  ) {
    return event.user != AuthenticationUserModel.empty
        ? AuthenticationState.authenticated(
            event.user,
          )
        : const AuthenticationState.unauthenticated();
  }
}
