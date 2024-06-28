import '../../../account.dart';
import '../domain/auth/phone_validator.dart';

class LogInWithPhoneUseCase {
  final AuthService _authService;
  final PhoneValidator _phoneValidator;

  const LogInWithPhoneUseCase(
    this._authService,
    this._phoneValidator,
  );

  Future<void> call(
    String phone,
  ) =>
      Future.sync(() => assertPhoneIsValid(phone)).then(
        (_) => _authService.logInWithPhone(
          phone,
        ),
      );

  void assertPhoneIsValid(String email) {
    if (!_phoneValidator.isValid(email)) {
      throw InvalidEmailException();
    }
  }
}
