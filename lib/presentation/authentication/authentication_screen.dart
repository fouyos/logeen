import 'package:awas/application/authentication/authentication_bloc.dart';
import 'package:awas/infrastructure/authentication/repositories/authentication_repository.dart';
import 'package:awas/presentation/authentication/widgets/authentication_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({
    @required this.repository,
    Key key,
  })  : assert(
          repository != null,
        ),
        super(
          key: key,
        );

  final AuthenticationRepository repository;

  @override
  Widget build(
    BuildContext context,
  ) {
    return RepositoryProvider.value(
      value: repository,
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
          repository: repository,
        ),
        child: AuthenticationWidget(),
      ),
    );
  }
}
