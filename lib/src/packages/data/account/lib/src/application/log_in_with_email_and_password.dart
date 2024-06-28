
import '../domain/auth/auth_service.dart';
import '../domain/auth/email_validator.dart';
import '../domain/exceptions.dart';

class LogInWithEmailAndPasswordUseCase {
  final AuthService _authService;
  final EmailValidator _emailValidator;

  const LogInWithEmailAndPasswordUseCase(
    this._authService,
    this._emailValidator,
  );

  Future<void> call(
    String email,
    String password,
  ) =>
      Future.sync(() => assertEmailIsValid(email)).then(
        (_) => _authService.logInWithEmailAndPassword(
          email,
          password,
        ),
      );

  void assertEmailIsValid(String email) {
    if (!_emailValidator.isValid(email)) {
      throw InvalidEmailException();
    }
  }
}
