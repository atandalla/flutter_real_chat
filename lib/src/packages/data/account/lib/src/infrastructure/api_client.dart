import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../domain/auth/login_with_email_exception.dart';
import '../domain/auth/login_with_phone_exception.dart';
import '../domain/auth/sign_up_with_email_exception.dart';

class AccountApiClient {
  final FirebaseAuth _instance;
  final GoogleSignIn _provider;

  AccountApiClient(
    this._instance,
    this._provider,
  );

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await _provider.signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await _instance.signInWithCredential(credential);
  }

  Future<void> signOut() => Future.wait([
        _instance.signOut(),
        _provider.signOut(),
      ]);

  Future<UserCredential> signUp(
    String email,
    String password,
    String name,
  ) {
    try {
      // Once signed in, return the UserCredential
      return _instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then(
        (userCredential) async {
          await userCredential.user?.updateDisplayName(name);
          return userCredential;
        },
      );
    } on FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordException.fromCode(e.code);
    } catch (_) {
      throw const SignUpWithEmailAndPasswordException();
    }
  }

  
  // Future<UserCredential> signUpPhone(
  //   String nombre,
  // ) {
  //   try {
  //     // Once signed in, return the UserCredential
  //     return _instance
  //         .createUserWithEmailAndPassword(
  //       email: email,
        
  //     )
  //         .then(
  //       (userCredential) async {
  //         await userCredential.user?.updateDisplayName(name);
  //         return userCredential;
  //       },
  //     );
  //   } on FirebaseAuthException catch (e) {
  //     throw SignUpWithEmailAndPasswordException.fromCode(e.code);
  //   } catch (_) {
  //     throw const SignUpWithEmailAndPasswordException();
  //   }
  // }

  Future<UserCredential> logInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      return await _instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw LogInWithEmailAndPasswordException.fromCode(e.code);
    } catch (_) {
      throw const LogInWithEmailAndPasswordException();
    }
  }

    Future<ConfirmationResult> logInWithPhone(
    String phone,
  ) async {
    try {
      return await _instance.signInWithPhoneNumber(phone);
    } on FirebaseAuthException catch (e) {
      throw LogInWithPhoneException.fromCode(e.code);
    } catch (_) {
      throw const LogInWithEmailAndPasswordException();
    }
  }

  Future<void> verifySmsCode({required String smsCode, required String verificationId}) async {
    final PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
    await _instance.signInWithCredential(credential);
  }

  Stream<User?> getUser() => _instance.authStateChanges();
}
