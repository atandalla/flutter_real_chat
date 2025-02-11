import 'package:real_chat/src/packages/core/ui/ui.dart';
import 'package:real_chat/src/packages/data/account/account.dart';
import 'package:real_chat/src/packages/features/login/login.dart';
import 'package:real_chat/src/packages/features/login/widgets/login_divider.dart';
import 'package:real_chat/src/packages/features/login/widgets/social_media_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final bloc = context.read<LoginBloc>();

    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.all(ChateoDimens.dimen_20),
            children: [
              const SizedBox(height: ChateoDimens.dimen_20),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'Ingresa',
                  style: textTheme.labelLarge?.copyWith(
                    decoration: TextDecoration.underline,
                    decorationThickness: 10,
                    decorationColor: theme.colorScheme.primary.withOpacity(0.7),
                  ),
                  children: [
                    TextSpan(
                      text: ' con ZeroPOS',
                      style: textTheme.labelLarge,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: ChateoDimens.dimen_20),
              Text(
                '¡Bienvenido de nuevo! Inicia sesión usando tu cuenta social o correo electrónico para continuar con nosotros.',
                style: TextStyle(
                  color: ChateoColors.darkGrey,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: ChateoDimens.dimen_96,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: ChateoDimens.dimen_24,
                  ),
                  child: SocialMediaButton(
                    icon: ChateoDrawables.getGoogleIconDrawable(),
                    borderColor: ChateoColors.black,
                    onTap: () => context
                        .read<SignInBloc>()
                        .add(const LogInWithGoogleEvent()),
                  ),

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     SocialMediaButton(
                  //       icon: ChateoDrawables.getFacebookIconDrawable(),
                  //       borderColor: ChateoColors.black,
                  //       onTap: () {},
                  //     ),
                  //     const SizedBox(width: ChateoDimens.dimen_20),
                  //     SocialMediaButton(
                  //       icon: ChateoDrawables.getGoogleIconDrawable(),
                  //       borderColor: ChateoColors.black,
                  //       onTap: () {},
                  //     ),
                  //     const SizedBox(width: ChateoDimens.dimen_20),
                  //     SocialMediaButton(
                  //       icon: ChateoDrawables.getAppleDarkIconDrawable(),
                  //       borderColor: ChateoColors.black,
                  //       onTap: () {},
                  //     ),
                  //   ],
                  // ),
                ),
              ),
              LoginDivider(
                color: ChateoColors.darkGrey,
              ),
              BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  return TextFormField(
                    textInputAction: TextInputAction.next,
                    onChanged: (value) =>
                        bloc.add(ChangeEmailLoginEvent(value)),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      label: const Text('Ingresa tu correo'),
                      error: state.showErrorEmail
                          ? const Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "Dirección de correo electrónico no válida",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            )
                          : null,
                    ),
                  );
                },
              ),
              const SizedBox(height: ChateoDimens.dimen_16),
              TextFormField(
                textInputAction: TextInputAction.done,
                onChanged: (value) => bloc.add(ChangePasswordLoginEvent(value)),
                obscureText: true,
                decoration: const InputDecoration(
                  label: Text('Ingresa tu password'),
                ),
              ),
              const SizedBox(height: ChateoDimens.dimen_92),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.white,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: ChateoDimens.dimen_20,
                ).copyWith(
                  bottom: ChateoDimens.dimen_48,
                ),
                child: BlocConsumer<LoginBloc, LoginState>(
                  listener: _listenState,
                  builder: (context, state) {
                    if (state.status == Status.loading) {
                      return const SizedBox(
                        height: 100,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    return ElevatedButton(
                      onPressed: state.showLogInButton
                          ? () =>
                              bloc.add(const LogInWithEmailAndPasswordEvent())
                          : null,
                      child: const Text('Iniciar Sesión'),
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _listenState(BuildContext context, LoginState state) {
    if (state.error is LogInWithEmailAndPasswordException) {
      final msg = (state.error as LogInWithEmailAndPasswordException).message;
      Fluttertoast.showToast(msg: msg);
    }
  }
}
