
import '../../../account.dart';

class SignUpPhoneUseCase {
  final AuthService _authService;
  final PhoneValidator _phoneValidator;

  const SignUpPhoneUseCase(
    this._authService,
    this._phoneValidator,
  );

  // Future<void> call(
  //   String? phone,
  // ) {
  //   return Future.sync(() {
  //     assertPhoneConfirmationIsValid(phone,);
  //   }).then((_) => _authService.signUpPhone(
  //         phone!
  //   ));
  // }

  void assertPhoneConfirmationIsValid(
      String? phone,) {
    if (phone == null ||
        !_phoneValidator.isValid(phone)) {
      throw InvalidPasswordConfirmationException();
    }
  }
}
