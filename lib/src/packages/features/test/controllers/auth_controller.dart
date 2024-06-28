import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:real_chat/src/packages/features/test/home_page.dart';
import 'package:real_chat/src/packages/features/test/verify_otp_page.dart';

class PhoneAuthController {
  static final _auth = FirebaseAuth.instance;

  static Future<void> sendOTP(BuildContext context, String phoneNumber) async {
    try {

      context.loaderOverlay.show();
    
      await _auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (phoneAuthCredential) {},
          verificationFailed: (error) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                  content: Text(error.message ??
                      "Algo paso al intentar verificar el número registrado")));
            // if(error.code == 'invalid-phone-number'){
            //   ScaffoldMessenger.of(context)
            //   ..hideCurrentSnackBar()
            //   ..showSnackBar(const SnackBar(content: const Text("Invalid Phone Number") ));
            // }
            // if(error.code == 'too-many-requests'){
            //   ScaffoldMessenger.of(context)
            //   ..hideCurrentSnackBar()
            //   ..showSnackBar(const SnackBar(content: const Text("Too Many Request") ));
            // }
          },
          codeSent: (verificationId, forceResendingToken) {
            context.loaderOverlay.hide();
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => VerifyOtpPage(
                      phoneNumber: phoneNumber,
                      verificationId: verificationId,
                    )));
          },
          codeAutoRetrievalTimeout: (verificationId) {});
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(error.message ?? "Algo paso al intentar verificar el número registrado"))
      );
    } catch (e) {
      print(e);
    } finally {
      context.loaderOverlay.hide();
    }
  }


  static Future<void> verifyOTP(BuildContext context, String verificationId, String smsCode) async {

    try {
      context.loaderOverlay.show();
      final credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
      await _auth.signInWithCredential(credential);
      if(!context.mounted) return;
      context.loaderOverlay.hide();
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => HomePage(),));
      
    } on FirebaseAuthException catch (error) {
        ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text(error.message ?? "Algo paso al intentar verificar el número registrado"))
        );
    } catch (e){
      print(e);
    } finally {
      context.loaderOverlay.hide();
    };
  }

  static Future<void> signOut() async {
    await _auth.signOut();
  }
}
