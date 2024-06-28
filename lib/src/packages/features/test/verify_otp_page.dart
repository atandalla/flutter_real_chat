import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:real_chat/src/packages/features/test/controllers/auth_controller.dart';

class VerifyOtpPage extends StatefulWidget {
  final String phoneNumber;
  final String verificationId;

  const VerifyOtpPage({super.key, required this.phoneNumber, required this.verificationId});

  @override
  State<VerifyOtpPage> createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends State<VerifyOtpPage> {

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Theme.of(context).colorScheme.primary),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.phoneNumber),
        titleTextStyle: theme.headlineSmall!
            .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(14),
        child: Column(
          children: [
            Text(
                "Para completar la verificación de tu dispositivo, porfavor ingresa los 6 dígitos enviado a tu teléfono"),
            SizedBox(
              height: 20,
            ),
            Pinput(
              length: 6,
              defaultPinTheme: defaultPinTheme,
              focusedPinTheme: focusedPinTheme,
              submittedPinTheme: submittedPinTheme,
              onCompleted: (value) {
                PhoneAuthController.verifyOTP(context, widget.verificationId, value);
              },
            )
          ],
        ),
      )),
    );
  }
}
