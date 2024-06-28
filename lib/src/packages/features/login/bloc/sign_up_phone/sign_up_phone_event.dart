part of 'sign_up_phone_bloc.dart';

sealed class SignUpPhoneEvent extends Equatable {
  const SignUpPhoneEvent();

  @override
  List<Object?> get props => [];
}

final class CreateAccountEvent extends SignUpPhoneEvent {
  const CreateAccountEvent();
}


final class ChangePhoneEvent extends SignUpPhoneEvent {
  const ChangePhoneEvent(this.phone);

  final String phone;

  @override
  List<Object?> get props => [phone];
}




