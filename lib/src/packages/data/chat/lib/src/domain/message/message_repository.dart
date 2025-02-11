
import '../../../../chat.dart';

abstract class MessageRepository {
  Stream<List<Message>> findAll(String chatId);

  Future<void> sendMessage(
    String chatUid,
    String msg,
    String sentBy,
    String sentTo,
    bool isAudio,
    bool isImage,
    bool isFile,
    MessageStatus status
  );

  Future<void> updateMessageStatusById(
    String uid,
    String name,
    MessageStatus status,
  );


}
