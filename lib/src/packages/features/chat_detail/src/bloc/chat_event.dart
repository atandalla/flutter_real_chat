part of 'chat_bloc.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

final class GetChatsEvent extends ChatEvent {
  const GetChatsEvent(
    this.chatUserUid,
    this.myUid,
  );

  final String chatUserUid;
  final String myUid;
}

final class SendMessageEvent extends ChatEvent {
  const SendMessageEvent(
    this.chatUserUid,
    this.myUid,
    this.msg, {
    this.isAudio = false,
    this.isImage = false,
    this.isFile = false,
    this.status = MessageStatus.NotDelivered
  });

  final String chatUserUid;
  final String myUid;
  final String msg;
  final bool isAudio;
  final bool isImage;
  final bool isFile;
  final MessageStatus status;

  @override
  List<Object> get props => [chatUserUid, myUid, msg, isAudio, isImage, isFile, status];
}

final class UpdateMessageStatusEvent extends ChatEvent {
  const UpdateMessageStatusEvent(
    this.chatId,
    this.messageId,
    this.status,
  );

  final String chatId;
  final String messageId;
  final MessageStatus status;

  @override
  List<Object> get props => [chatId, messageId, status];
}