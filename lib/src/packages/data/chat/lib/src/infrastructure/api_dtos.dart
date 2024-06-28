
import 'package:real_chat/src/packages/core/utils/utils.dart';
import 'package:real_chat/src/packages/data/chat/chat.dart';

class ChatUserDto {
  final String uid;
  final String name;
  final String? photoUrl;
  final bool status;

  ChatUserDto({
    required this.uid,
    required this.name,
    required this.photoUrl,
    required this.status,
  });

  factory ChatUserDto.fromJson(Map jsonObj) {
    final String uid = jsonObj['uid'];
    final String name = jsonObj['name'];
    final String? photoUrl = jsonObj['photoUrl'];
    final bool status = jsonObj['status'];

    return ChatUserDto(
      uid: uid,
      name: name,
      photoUrl: photoUrl,
      status: status,
    );
  }

  static List<ChatUserDto> fromJsonArray(List jsonArray) =>
      jsonArray.map((e) => ChatUserDto.fromJson(e)).toList();
}

class MessageDto {
  final String uid;
  final String msg;
  final String date;
  final String sentBy;
  final bool isAudio;
  final bool isImage;
  final bool isFile;
  final MessageStatus status;

  const MessageDto(
    this.uid,
    this.msg,
    this.date,
    this.sentBy,
    this.isAudio,
    this.isImage,
    this.isFile,
    this.status
  );

  factory MessageDto.fromJson(Map jsonObj) {
    final String uid = jsonObj['uid'];
    final String message = jsonObj['message'];
    final String date = jsonObj['messageDate'];
    final String sentBy = jsonObj['sentBy'];
    final bool isAudio = jsonObj['isAudio'];
    final bool isImage = jsonObj['isImage'];
    final bool isFile = jsonObj['isFile'];
    final MessageStatus status = jsonObj['status'];

    return MessageDto(
      uid,
      message,
      date,
      sentBy,
      isAudio,
      isImage,
      isFile,
      status
    );
  }

  static List<MessageDto> fromJsonArray(List jsonArray) => jsonArray
      .map((e) => MessageDto.fromJson(e))
      .sortedBy((messages) => messages.date)
      .toList();
}
