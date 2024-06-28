import '../user/user.dart';

abstract class AuthService {
  Future<void> logInWithGoogle();

  Future<void> logInWithEmailAndPassword(
    String email,
    String password,
  );

  Future<void> logInWithPhone(String phone);
  // Future<void> signUpPhone(String phone);

  Future<void> signUp(
    String email,
    String password,
    String name,
  );

  Future<void> logOut();

  Stream<User?> getUser();
}
