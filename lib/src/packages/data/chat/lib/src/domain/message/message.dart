import 'package:equatable/equatable.dart';

enum MessageStatus { NotDelivered, Delivered, Read }

class Message extends Equatable {
  final String id; // Añadir campo ID
  final String msg;
  final DateTime date;
  final String sentBy;
  final bool isAudio;
  final bool isImage;
  final bool isFile;
  final MessageStatus status;

  const Message({
    required this.id, // Añadir campo ID
    required this.msg,
    required this.date,
    required this.sentBy,
    required this.isAudio,
    required this.isImage,
    required this.isFile,
    this.status = MessageStatus.NotDelivered,
  });

  @override
  List<Object?> get props => [
        id, // Añadir campo ID
        msg,
        date,
        sentBy,
        isAudio,
        isImage,
        isFile,
        status,
      ];
}
