import 'package:awas/application/authentication/authentication_bloc.dart';
import 'package:awas/domain/core/logger.dart';
import 'package:awas/domain/core/router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class AuthenticationWidget extends StatefulWidget {
  @override
  _AuthenticationWidgetState createState() => _AuthenticationWidgetState();
}

class _AuthenticationWidgetState extends State<AuthenticationWidget> {
  final _router = Routes.router;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Builder(
      builder: (
        context,
      ) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (
            context,
            state,
          ) {
            switch (state.status) {
              case AuthenticationStatus.unauthenticated:
                _router.navigateTo(
                  context,
                  '/login',
                  replace: true,
                );

                break;
              case AuthenticationStatus.authenticated:
                _router.navigateTo(
                  context,
                  '/device',
                  clearStack: true,
                  replace: true,
                );

                break;
              default:
                logger.w(
                  state,
                );

                break;
            }
          },

          /// This empty view avoid the view to be returned null.
          child: Container(
            width: 0,
            height: 0,
          ),
        );
      },
    );
  }
}
