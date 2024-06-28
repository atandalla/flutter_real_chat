import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_chat/src/packages/data/chat/lib/src/application/send_message_use_case.dart';
import 'package:real_chat/src/packages/data/chat/lib/src/application/update_message_status_use_case.dart';

import '../../../../data/chat/chat.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc(
    this._getChatUseCase,
    this._sendMessageUseCase,
    this._updateMessageUseCase
  ) : super(const ChatLoading()) {
    on<GetChatsEvent>(_onGetChatsEvent);
    on<SendMessageEvent>(_onSendMessageEvent);
    on<UpdateMessageStatusEvent>(_onUpdateMessageStatusEvent);
  }

  final GetChatUseCase _getChatUseCase;
  final SendMessageUseCase _sendMessageUseCase;
  final UpdateMessageStatusUseCase _updateMessageUseCase;



  FutureOr<void> _onGetChatsEvent(GetChatsEvent event, Emitter<ChatState> emit) async {
    emit(ChatLoading());
    try {
      final chatId = getChatId(event.myUid, event.chatUserUid);
      final messages = await _getChatUseCase(chatId).first;

      for (var message in messages) {
        if (message.status == MessageStatus.Delivered) {
          await _updateMessageUseCase.call(
            chatId,
            message.id, // Asegúrate de que el mensaje tiene un ID único
            MessageStatus.Read,
          );
        }
      }

      emit(ChatSuccess(messages, event.myUid));
    } catch (e) {
      emit(ChatError());
    }
  }

  // FutureOr<void> _onGetChatsEvent(
  //     GetChatsEvent event, Emitter<ChatState> emit) {
  //   return emit.forEach<List<Message>>(
  //     _getChatUseCase(getChatId(event.myUid, event.chatUserUid)),
  //     onData: (data) => ChatSuccess(
  //       data,
  //       event.myUid,
  //     ),
  //     onError: (error, stackTrace) => const ChatError(),
  //   );
  // }

FutureOr<void> _onSendMessageEvent(
    SendMessageEvent event,
    Emitter<ChatState> emit,
  ) {
    return emit.onEach(
      _sendMessageUseCase(
        getChatId(event.myUid, event.chatUserUid),
        event.msg,
        event.myUid,
        event.chatUserUid,
        event.isAudio,
        event.isImage,
        event.isFile,
        event.status
      ).asStream(),
      onData: (data) {},
    );
  }


  FutureOr<void> _onUpdateMessageStatusEvent(UpdateMessageStatusEvent event, Emitter<ChatState> emit) async {
    try {
      await _updateMessageUseCase.call(
        event.chatId,
        event.messageId,
        event.status,
      );
    } catch (e) {
      // Handle error
    }
  }

  String getChatId(String myUid, String chatUserUid) {
    final ids = [myUid, chatUserUid];
    ids.sort();
    return "${ids[0]}_${ids[1]}";
  }

}

  // FutureOr<void> _onSendMessageEvent(
  //   SendMessageEvent event,
  //   Emitter<ChatState> emit,
  // ) {
  //   return emit.onEach(
  //     _sendMessageUseCase(
  //       getChatId(event.myUid, event.chatUserUid),
  //       event.msg,
  //       event.myUid,
  //       event.chatUserUid,
  //     ).asStream(),
  //     onData: (data) {},
  //   );
  // }