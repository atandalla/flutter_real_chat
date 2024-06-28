import 'dart:async';

import 'package:real_chat/src/packages/core/ui/ui.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/ui/ui.dart';
import '../../../../data/account/account.dart';

part 'phone_event.dart';
part 'phone_state.dart';

class PhoneBloc extends Bloc<PhoneEvent, PhoneState> {
  PhoneBloc(
    this._logInWithPhoneUseCase,
  ) : super(const PhoneState()) {
    on<LogInWithPhoneEvent>(_onLogInWithPhoneEvent);
    on<ChangePhoneLoginEvent>(_onChangePhoneLoginEvent);
  }

  final LogInWithPhoneUseCase _logInWithPhoneUseCase;

  FutureOr<void> _onLogInWithPhoneEvent(LogInWithPhoneEvent event, Emitter<PhoneState> emit) async {
    emit(state.copyWith(status: Status.loading, error: Object()));
    return emit.forEach<void>(
      _logInWithPhoneUseCase(
        state.phone!.trim(),
      ).asStream(),
      onData: (value) => state.copyWith(status: Status.success),
      onError: (error, __) =>
          state.copyWith(status: Status.error, error: error),
    );
  }

  FutureOr<void> _onChangePhoneLoginEvent(ChangePhoneLoginEvent event, Emitter<PhoneState> emit) {
    emit(state.copyWith(phone: event.phone, error: Object()));
  }
  
}
