import 'package:real_chat/src/app/navigator/app_navigator.dart';
import 'package:real_chat/src/packages/core/ui/ui.dart';
import 'package:real_chat/src/packages/features/login/login.dart';
import 'package:real_chat/src/packages/features/login/widgets/login_divider.dart';
import 'package:real_chat/src/packages/features/login/widgets/onboarding_button.dart';
import 'package:real_chat/src/packages/features/login/widgets/social_media_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/onboarding_button_phone.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Image.asset(
              ChateoDrawables.getOnboardingBackgroundDrawable(),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(ChateoDimens.dimen_20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(height: 10,),
                  //Image.asset(ChateoDrawables.getAppIconDrawable(), scale: 2,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Chat',
                        style: textTheme.displayLarge?.copyWith(
                          color: Colors.white,
                          fontSize: 38,
                          
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        'box',
                        style: textTheme.displayLarge?.copyWith(
                          color: Color.fromARGB(255, 213, 130, 240),
                          fontSize: 38,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: ChateoDimens.dimen_32),
                  Text(

                    'Conecta amigos fácil y rápidamente',
                    style: textTheme.displayLarge?.copyWith(
                      color: Colors.white,
                      fontSize: 58
                    ),
                  ),
                  const SizedBox(
                    height: ChateoDimens.dimen_8,
                  ),
                  Text(
                    'Nuestra aplicación de chat es la manera perfecta de mantenerse conectado con amigos y familiares.',
                    style: textTheme.bodyMedium
                        ?.copyWith(color: ChateoColors.grey),
                  ),
                  const SizedBox(
                    height: ChateoDimens.dimen_12,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: ChateoDimens.dimen_12,
                    ),
                    child: SocialMediaButton(
                      icon: ChateoDrawables.getGoogleIconDrawable(),
                      onTap: () => context
                          .read<SignInBloc>()
                          .add(const LogInWithGoogleEvent()),
                    ),
                    //  Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     // SocialMediaButton(
                    //     //   icon: ChateoDrawables.getFacebookIconDrawable(),
                    //     //   onTap: () {},
                    //     // ),
                    //     // const SizedBox(width: ChateoDimens.dimen_20),

                    //     // const SizedBox(width: ChateoDimens.dimen_20),
                    //     // SocialMediaButton(
                    //     //   icon: ChateoDrawables.getAppleIconDrawable(),
                    //     //   onTap: () {},
                    //     // ),
                    //   ],
                    // ),
                  ),
                  const LoginDivider(),
                  OnboardingButton(
                    onTap: () => AppNavigator.navigateToSignUp(context),
                  ),
                  const SizedBox(
                    height: ChateoDimens.dimen_20,
                  ),
                  TextButton(
                    onPressed: () => AppNavigator.navigateToLogIn(context),
                    child: RichText(
                      text: TextSpan(
                        text: 'Cuenta existente? ',
                        style: TextStyle(color: ChateoColors.grey),
                        children: const [
                          TextSpan(
                            text: 'Iniciar Sesión',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
