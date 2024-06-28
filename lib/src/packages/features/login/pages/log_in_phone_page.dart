
import 'package:real_chat/src/packages/core/ui/ui.dart';
import 'package:real_chat/src/packages/features/login/bloc/sign_up_phone/sign_up_phone_bloc.dart';
import 'package:real_chat/src/packages/features/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpPhonePage extends StatefulWidget {
  const SignUpPhonePage({super.key});

  @override
  State<SignUpPhonePage> createState() => _SignUpPhonePageState();
}

class _SignUpPhonePageState extends State<SignUpPhonePage> {
  late SignUpBloc _bloc;
  final _globalKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    _bloc = context.read<SignUpBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      key: _globalKey,
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
                  text: 'Sign up with Phone ',
                  style: textTheme.labelLarge,
                  children: [
                    TextSpan(
                      text: 'Phone',
                      style: textTheme.labelLarge?.copyWith(
                        decoration: TextDecoration.underline,
                        decorationThickness: 10,
                        decorationColor:
                            theme.colorScheme.primary.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: ChateoDimens.dimen_20),
              Text(
                '¡Comience a chatear con amigos y familiares registrandote en nuestra aplicación de chat!',
                style: TextStyle(
                  color: ChateoColors.darkGrey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: ChateoDimens.dimen_40),
              TextFormField(
                textInputAction: TextInputAction.next,
                onChanged: (value) => _bloc.add(ChangeNameEvent(value)),
                decoration: const InputDecoration(
                  label: Text('Tu nombre'),
                ),
              ),
              const SizedBox(height: ChateoDimens.dimen_16),
              BlocBuilder<SignUpBloc, SignUpState>(
                builder: (context, state) {
                  return TextFormField(
                    textInputAction: TextInputAction.next,
                    onChanged: (value) => _bloc.add(ChangeEmailEvent(value)),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      label: Text(
                        'Tu Email',
                        style: TextStyle(
                          color: state.showErrorEmail
                              ? Colors.red
                              : theme.colorScheme.primary,
                        ),
                      ),
                      error: state.showErrorEmail
                          ? const Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "Invalid email address",
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
                textInputAction: TextInputAction.next,
                onChanged: (value) => _bloc.add(ChangePasswordEvent(value)),
                obscureText: true,
                decoration: const InputDecoration(
                  label: Text('Password'),
                ),
              ),
              const SizedBox(height: ChateoDimens.dimen_16),
              BlocBuilder<SignUpBloc, SignUpState>(
                builder: (context, state) {
                  return TextFormField(
                    textInputAction: TextInputAction.done,
                    onChanged: (value) => _bloc.add(ChangeConfirmEvent(value)),
                    obscureText: true,
                    decoration: InputDecoration(
                      label: Text(
                        'Confirm Password',
                        style: TextStyle(
                          color: state.showErrorConfirm
                              ? Colors.red
                              : theme.colorScheme.primary,
                        ),
                      ),
                      error: state.showErrorConfirm
                          ? const Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "Invalid confirm password",
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
              const SizedBox(height: ChateoDimens.dimen_92),
            ],
          ),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: Container(
          //     color: Colors.white,
          //     width: double.infinity,
          //     child: Padding(
          //       padding: const EdgeInsets.symmetric(
          //         horizontal: ChateoDimens.dimen_20,
          //       ).copyWith(
          //         bottom: ChateoDimens.dimen_32,
          //       ),
          //       child: BlocConsumer<SignUpBloc, SignUpState>(
          //         listener: _listenState,
          //         builder: (context, state) {
          //           if (state.status == Status.loading) {
          //             return const SizedBox(
          //               height: 100,
          //               child: Center(
          //                 child: CircularProgressIndicator(),
          //               ),
          //             );
          //           }
          //           return ElevatedButton(
          //             onPressed: state.showCreateAccountButton
          //                 ? () => _bloc.add(const CreateAccountEvent())
          //                 : null,
          //             child: const Text('Create an account'),
          //           );
          //         },
          //       ),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }

  // void _listenState(BuildContext context, SignUpPhoneState state) {
  //   if (state.error is SignUpWithEmailAndPasswordException) {
  //     final msg = (state.error as SignUpWithEmailAndPasswordException).message;
  //     Fluttertoast.showToast(msg: msg);
  //   }
  // }
}
