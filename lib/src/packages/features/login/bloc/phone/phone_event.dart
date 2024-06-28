part of 'phone_bloc.dart';

sealed class PhoneEvent extends Equatable {
  const PhoneEvent();

  @override
  List<Object?> get props => [];
}

final class LogInWithPhoneEvent extends PhoneEvent {
  const LogInWithPhoneEvent();
}

final class ChangePhoneLoginEvent extends PhoneEvent {
  const ChangePhoneLoginEvent(this.phone);

  final String phone;

  @override
  List<Object?> get props => [phone];
}



















// class UpdateNextButtonStatusEvent extends PhoneEvent {
//   const UpdateNextButtonStatusEvent(this.isPhoneNumberInputValidated);

//   final bool isPhoneNumberInputValidated;

//   @override
//   List<Object?> get props => [isPhoneNumberInputValidated];
// }


// class VerifyPhoneNumberEvent extends PhoneEvent {
//   const VerifyPhoneNumberEvent();

//   @override
//   List<Object?> get props => [];
// }

// class SmsCodeChangedEvent extends PhoneEvent {
//   const SmsCodeChangedEvent(this.smsCode);

//   final String smsCode;

//   @override
//   List<Object?> get props => [smsCode];
// }
