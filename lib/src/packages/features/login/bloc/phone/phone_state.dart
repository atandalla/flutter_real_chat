part of 'phone_bloc.dart';

final class PhoneState {
  const PhoneState({
    this.status = Status.initial,
    this.phone,    
    this.error,
  });

  final Status status;
  final String? phone;
  final Object? error;

  bool get showLogInButton => ((phone?.isNotEmpty ?? false));

  bool get showErrorPhone => error != null ? error is InvalidPhoneConfirmationException : false;

  PhoneState copyWith({
    final Status? status,
    final String? phone,
    final Object? error,
  }) =>
      PhoneState(
        status: status ?? this.status,
        phone: phone ?? this.phone,
        error: error ?? this.error,
      );
}
