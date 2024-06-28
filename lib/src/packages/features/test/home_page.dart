

import 'package:flutter/material.dart';
import 'package:real_chat/src/packages/features/test/controllers/auth_controller.dart';
import 'package:real_chat/src/packages/features/test/onboarding_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        centerTitle: true,
      ),
      body: Center(
         child: FilledButton.icon(
          onPressed: (){
            PhoneAuthController.signOut();
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const OnboardingPage(),));
          } , 
          label: const Text("Cerrar Sesión"),
          icon: const Icon(Icons.logout),
          style: FilledButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.error
          ),
          ),
      ),
    );
  }
}