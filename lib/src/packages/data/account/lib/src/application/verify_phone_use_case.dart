// import '../../../account.dart';
// import '../domain/auth/phone_validator.dart';

// class VerifyPhoneUseCase {
//   final AuthService _authService;
//   final PhoneValidator _phoneValidator;

//   const VerifyPhoneUseCase(
//     this._authService,
//     this._phoneValidator,
//   );

//   Future<void> call(
//     String smsCode,
//     String verificationId,
//   ) =>
//       Future.sync(() => _authService.verifySmsCode(
//           smsCode: smsCode,
//           verificationId: verificationId
//         ),);

//   void assertPhoneIsValid(String phone) {
//     if (!_phoneValidator.isValid(phone)) {
//       throw InvalidEmailException();
//     }
//   }
// }
