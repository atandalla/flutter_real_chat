import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:real_chat/src/packages/features/test/controllers/auth_controller.dart';
import 'package:real_chat/src/packages/features/test/verify_otp_page.dart';

class PhonePage extends StatefulWidget {
  const PhonePage({super.key});

  @override
  State<PhonePage> createState() => _PhonePageState();
}

class _PhonePageState extends State<PhonePage> {
  
  final PhoneNumber initialPhone = PhoneNumber(isoCode: "EC");
  bool enableOtpBtn = false;
  String phoneNumber = "";

  getOTP() {
    PhoneAuthController.sendOTP(context, phoneNumber);
    // Navigator.of(context).push(MaterialPageRoute(
    //   builder: (context) {
    //     return VerifyOtpPage(phoneNumber: phoneNumber);
    //   },
    // ));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Ingresa tu numero de telefono"),
        titleTextStyle: theme.headlineSmall!
            .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            const Text(
              "Anthony necesitas verificar tu celular para poder continuar",
            ),
            const SizedBox(
              height: 30,
            ),
            InternationalPhoneNumberInput(
              onInputChanged: (value) {
                setState(() {
                  phoneNumber = value.phoneNumber!;
                });
              },
              onInputValidated: (value) {
                setState(() {
                  enableOtpBtn = value;
                });
              },
              initialValue: initialPhone,
              formatInput: true,
              autoFocus: true,
              keyboardType: TextInputType.phone,
              selectorConfig: const SelectorConfig(
                  useEmoji: true,
                  selectorType: PhoneInputSelectorType.BOTTOM_SHEET),
              inputDecoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  border: OutlineInputBorder()),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                  onPressed: enableOtpBtn ? getOTP : null,
                  child: const Text("Obtener OTP")),
            )
          ],
        ),
      )),
    );
  }
}
