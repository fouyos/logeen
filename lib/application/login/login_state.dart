part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.email = const AuthenticationEmailObject.pure(),
    this.password = const AuthenticationPasswordObject.pure(),
    this.status = FormzStatus.pure,
  });

  final AuthenticationEmailObject email;
  final AuthenticationPasswordObject password;
  final FormzStatus status;

  @override
  List<Object> get props => [
        email,
        password,
        status,
      ];

  LoginState copyWith({
    AuthenticationEmailObject email,
    AuthenticationPasswordObject password,
    FormzStatus status,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }
}
