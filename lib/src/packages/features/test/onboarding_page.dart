import 'package:flutter/material.dart';
import 'package:real_chat/src/packages/features/test/phone_page.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(18),
        child: Center(
          child: Column(
            children: [
              
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Zero', style: theme.displaySmall!.copyWith(fontWeight: FontWeight.bold, fontSize: 34),),
                    Text('CHAT', style: theme.displaySmall!.copyWith(fontWeight: FontWeight.bold, fontSize: 34, color: Color.fromARGB(255, 239, 121, 52)),),
                  ],
                ),
              ),
              
              //const Spacer(),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Image.asset('assets/images/img_chatbot.png', scale: 1),
              ),
              //const Spacer(),
              Text(
                "Bienvenido a nuestro Chat Inteligente ZeroChat",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .apply(fontWeightDelta: 5, fontSizeDelta: 15),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 30),
                child: Text(
                  "Nuestra APP es la manera perfecta para mantenerte conectado con tu familia y amigos",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .apply(fontWeightDelta: 0),
                ),
              ),
              const Spacer(),
              Expanded(
                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Color.fromRGBO(221, 89, 63, 1)),
                          shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)
                          ))
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PhonePage(),
                              ));
                        },
                        label: const Text("Regístrate con tu correo"),
                        icon: const Icon(Icons.phone_android_rounded),
                      ),
                    ),
                    Text("OR"),

                  ],
                ),
              )
              
            ],
          ),
        ),
      )),
    );
  }
}
