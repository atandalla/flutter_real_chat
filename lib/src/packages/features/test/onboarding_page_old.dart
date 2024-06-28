import 'package:flutter/material.dart';
import 'package:real_chat/src/packages/features/test/phone_page.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(18),
        child: Center(
          child: Column(
            children: [
              const Spacer(),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Image.asset('assets/images/onboarding.png'),
              ),
              const Spacer(),
              Text(
                "Bienvenido a la Autenticación por Celular.",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .apply(fontWeightDelta: 2),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 30),
                child: Text(
                  "El mejor tutorial para principiantes",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .apply(fontWeightDelta: 2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PhonePage(),
                          ));
                    },
                    label: const Text("Continuar con celular"),
                    icon: const Icon(Icons.phone_android_rounded),
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
