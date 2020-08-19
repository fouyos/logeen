import 'package:awas/domain/authentication/objects/authentication_email_object.dart';
import 'package:awas/domain/authentication/objects/authentication_password_object.dart';
import 'package:awas/infrastructure/authentication/repositories/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'login_state.dart';

class LoginBloc extends Cubit<LoginState> {
  LoginBloc(
    this._repository,
  )   : assert(
          _repository != null,
        ),
        super(
          const LoginState(),
        );

  final AuthenticationRepository _repository;

  void emailChanged(
    String value,
  ) {
    final email = AuthenticationEmailObject.dirty(
      value,
    );
    emit(
      state.copyWith(
        email: email,
        status: Formz.validate(
          [
            email,
            state.password,
          ],
        ),
      ),
    );
  }

  void passwordChanged(
    String value,
  ) {
    final password = AuthenticationPasswordObject.dirty(
      value,
    );
    emit(
      state.copyWith(
        password: password,
        status: Formz.validate(
          [
            state.email,
            password,
          ],
        ),
      ),
    );
  }

  Future<void> logInWithCredentials() async {
    if (!state.status.isValidated) return;

    emit(
      state.copyWith(
        status: FormzStatus.submissionInProgress,
      ),
    );

    try {
      await _repository.logInWithEmailAndPassword(
        email: state.email.value,
        password: state.password.value,
      );

      emit(
        state.copyWith(
          status: FormzStatus.submissionSuccess,
        ),
      );
    } on Exception {
      emit(
        state.copyWith(
          status: FormzStatus.submissionFailure,
        ),
      );
    }
  }

  Future<void> logInWithGoogle() async {
    try {
      await _repository.logInWithGoogle();

      emit(
        state.copyWith(
          status: FormzStatus.submissionSuccess,
        ),
      );
    } on Exception {
      emit(
        state.copyWith(
          status: FormzStatus.submissionFailure,
        ),
      );
    }
  }
}
