import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:real_chat/src/packages/core/ui/ui.dart';
import 'package:real_chat/src/packages/data/account/account.dart';
import 'package:real_chat/src/packages/data/account/lib/src/application/sign_up_phone_use_case.dart';

part 'sign_up_phone_event.dart';
part 'sign_up_phone_state.dart';

// class SignUpPhoneBloc extends Bloc<SignUpPhoneEvent, SignUpPhoneState> {
//    SignUpPhoneBloc(
//     this._signUpPhoneUseCase,
//   ) : super(const SignUpPhoneState()) {
//     on<CreateAccountEvent>(_onCreateAccountEvent);
//     on<ChangePhoneEvent>(_onChangePhoneEvent);
//   }


//   final SignUpPhoneUseCase _signUpPhoneUseCase;

//   FutureOr<void> _onCreateAccountEvent(
//     CreateAccountEvent event,
//     Emitter emit,
//   ) async {
//     emit(state.copyWith(status: Status.loading, error: Object()));
//     return emit.forEach<void>(
//       _signUpPhoneUseCase(
//         state.phone
//       ).asStream(),
//       onData: (value) => state.copyWith(status: Status.success),
//       onError: (error, __) => state.copyWith(
//         status: Status.error,
//         error: error,
//       ),
//     );
//   }

//   FutureOr<void> _onChangePhoneEvent(
//     ChangePhoneEvent event,
//     Emitter<SignUpPhoneState> emit,
//   ) {
//     emit(state.copyWith(phone: event.phone, error: Object()));
//   }
// }


// class SignUpPhoneBloc extends Bloc<SignUpEvent, SignUpState> {
//   SignUpPhoneBloc(
//     this._signUpUseCase,
//   ) : super(const SignUpState()) {
//     on<CreateAccountEvent>(_onCreateAccountEvent);
//     on<ChangeNameEvent>(_onChangeNameEvent);
//     on<ChangeEmailEvent>(_onChangeEmailEvent);
//     on<ChangePasswordEvent>(_onChangePasswordEvent);
//     on<ChangeConfirmEvent>(_onChangeConfirmEvent);
//   }

//   final SignUpUseCase _signUpUseCase;

//   FutureOr<void> _onCreateAccountEvent(
//     CreateAccountEvent event,
//     Emitter emit,
//   ) async {
//     emit(state.copyWith(status: Status.loading, error: Object()));
//     return emit.forEach<void>(
//       _signUpUseCase(
//         state.email,
//         state.password,
//         state.confirm,
//         state.name,
//       ).asStream(),
//       onData: (value) => state.copyWith(status: Status.success),
//       onError: (error, __) => state.copyWith(
//         status: Status.error,
//         error: error,
//       ),
//     );
//   }

//   FutureOr<void> _onChangeNameEvent(
//     ChangeNameEvent event,
//     Emitter<SignUpState> emit,
//   ) {
//     emit(state.copyWith(name: event.name, error: Object()));
//   }

//   FutureOr<void> _onChangeEmailEvent(
//     ChangeEmailEvent event,
//     Emitter<SignUpState> emit,
//   ) {
//     emit(state.copyWith(email: event.email, error: Object()));
//   }

//   FutureOr<void> _onChangePasswordEvent(
//     ChangePasswordEvent event,
//     Emitter<SignUpState> emit,
//   ) {
//     emit(state.copyWith(password: event.password, error: Object()));
//   }

//   FutureOr<void> _onChangeConfirmEvent(
//     ChangeConfirmEvent event,
//     Emitter<SignUpState> emit,
//   ) {
//     emit(state.copyWith(confirm: event.confirm, error: Object()));
//   }
// }
