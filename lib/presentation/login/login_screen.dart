import 'package:awas/application/login/login_bloc.dart';
import 'package:awas/infrastructure/authentication/repositories/authentication_repository.dart';
import 'package:awas/presentation/login/widgets/login_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: RepositoryProvider(
        create: (
          context,
        ) {
          return AuthenticationRepository();
        },
        child: BlocProvider(
          create: (
            context,
          ) {
            return LoginBloc(
              context.repository<AuthenticationRepository>(),
            );
          },
          child: LoginWidget(),
        ),
      ),
    );
  }
}
