import 'package:awas/application/login/login_bloc.dart';
import 'package:awas/domain/core/logger.dart';
import 'package:awas/presentation/core/custom_icons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:formz/formz.dart';

class LoginWidget extends StatelessWidget {
  @override
  Widget build(
    BuildContext context,
  ) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (
        context,
        state,
      ) {
        if (state.status.isSubmissionFailure) {
          Scaffold.of(
            context,
          )
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text(
                  'Are you regeistered?',
                ),
              ),
            );
        }
      },
      child: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _AvatarField(),
              const SizedBox(
                height: 12,
              ),
              Neumorphic(
                margin: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 16,
                ),
                style: NeumorphicStyle(
                  boxShape: NeumorphicBoxShape.roundRect(
                    BorderRadius.circular(
                      48,
                    ),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const _FormField(
                      label: 'Email',
                      hint: 'Enter your valid address here',
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    const _FormField(
                      label: 'Password',
                      hint: 'Enter your password here',
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    _LoginButtonField(),
                  ],
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              NeumorphicText(
                'Another Options',
                style: NeumorphicStyle(
                  color: Colors.black87,
                ),
                textStyle: NeumorphicTextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              _GoogleButtonField(),
            ],
          ),
        ),
      ),
    );
  }
}

class _AvatarField extends StatelessWidget {
  @override
  Widget build(
    BuildContext context,
  ) {
    return Neumorphic(
      padding: const EdgeInsets.all(
        32,
      ),
      style: NeumorphicStyle(
        depth: NeumorphicTheme.embossDepth(
          context,
        ),
      ),
      child: NeumorphicIcon(
        CustomIcons.user_shield,
        size: 80,
      ),
    );
  }
}

class _FormField extends StatelessWidget {
  const _FormField({
    this.label,
    this.hint,
  });

  final String label;
  final String hint;

  @override
  Widget build(
    BuildContext context,
  ) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (
        previous,
        current,
      ) {
        return _formTypeBuilder(
          previous,
          current,
        );
      },
      builder: (
        context,
        state,
      ) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 8,
              ),
              child: Text(
                label,
                style: Theme.of(
                  context,
                ).textTheme.subtitle2,
              ),
            ),
            Neumorphic(
              margin: const EdgeInsets.only(
                left: 8,
                right: 8,
                top: 4,
                bottom: 4,
              ),
              style: NeumorphicStyle(
                depth: NeumorphicTheme.embossDepth(
                  context,
                ),
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 14,
                horizontal: 18,
              ),
              child: _formTypeTextField(
                context,
                state,
              ),
            )
          ],
        );
      },
    );
  }

  /// TODO must be another logic which better than current implementation.
  bool _formTypeBuilder(
    LoginState previous,
    LoginState current,
  ) {
    switch (label.toLowerCase()) {
      case 'email':
        return previous.email != current.email;

        break;
      case 'password':
        return previous.password != current.password;

        break;
      default:
        logger.w(
          'Previous state: $previous, Current state: $current',
        );

        return null;

        break;
    }
  }

  Widget _formTypeTextField(
    BuildContext context,
    LoginState state,
  ) {
    switch (label.toLowerCase()) {
      case 'email':
        return TextField(
          key: const Key(
            'loginForm_emailInput_textField',
          ),
          onChanged: (
            email,
          ) {
            context.bloc<LoginBloc>().emailChanged(
                  email,
                );
          },
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint,
            errorText: state.email.invalid ? 'Invalid Email' : null,
          ),
        );

        break;
      case 'password':
        return TextField(
          key: const Key(
            'loginForm_passwordInput_textField',
          ),
          onChanged: (
            password,
          ) {
            context.bloc<LoginBloc>().passwordChanged(
                  password,
                );
          },
          obscureText: true,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint,
            errorText: state.password.invalid ? 'Invalid Password' : null,
          ),
        );

        break;
      default:
        return null;

        break;
    }
  }
}

class _LoginButtonField extends StatelessWidget {
  @override
  Widget build(
    BuildContext context,
  ) {
    return Align(
      alignment: Alignment.centerRight,
      child: BlocBuilder<LoginBloc, LoginState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          return state.status.isSubmissionInProgress
              ? const CircularProgressIndicator()
              : NeumorphicButton(
                  key: const Key(
                    'loginForm_loginButton_raisedButton',
                  ),
                  onPressed: state.status.isValidated
                      ? () => context.bloc<LoginBloc>().logInWithCredentials()
                      : null,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  style: NeumorphicStyle(
                    boxShape: NeumorphicBoxShape.roundRect(
                      BorderRadius.circular(
                        48,
                      ),
                    ),
                  ),
                  child: Text(
                    'SIGN IN',
                    style: Theme.of(context).textTheme.button,
                  ),
                );
        },
      ),
    );
  }
}

class _GoogleButtonField extends StatelessWidget {
  @override
  Widget build(
    BuildContext context,
  ) {
    return NeumorphicButton(
      key: const Key(
        'loginForm_googleButton_raisedButton',
      ),
      padding: const EdgeInsets.all(
        16.0,
      ),
      onPressed: () => context.bloc<LoginBloc>().logInWithGoogle(),
      child: NeumorphicIcon(
        CustomIcons.google,
        size: 46,
      ),
    );
  }
}
