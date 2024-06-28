
import 'package:firebase_database/firebase_database.dart';

import '../../../chat.dart';

class ChatApiClient {
  final FirebaseDatabase _instance;

  ChatApiClient(this._instance);

  Stream<List<ChatUserDto>> getUserChats() {
    try {
      return _instance
          .ref("status")
          .orderByChild("status")
          .onValue
          .map(
            (event) => event.snapshot.value != null
                ? (event.snapshot.value as Map).map((key, value) {
                    final newValue = value as Map;
                    newValue['uid'] = key;
                    return MapEntry(key, newValue);
                  })
                : {},
          )
          .map(
            (event) => ChatUserDto.fromJsonArray(event.values.toList()),
          );
    } catch (e) {
      throw ChatsException();
    }
  }

  Stream<List<MessageDto>> getChat(String chatId) {
    try {
      return _instance.ref("chats").child("$chatId/messages").onValue.map(
            (event) => MessageDto.fromJsonArray(
              event.snapshot.value != null
                  ? (event.snapshot.value as Map).values.toList()
                  : [],
            ),
          );
    } catch (e) {
      throw ChatsException();
    }
  }

  Future<void> sendMessage(
    String chatUid,
    String msg,
    String sentBy,
    String sentTo,
    bool isAudio,
    bool isImage,
    bool isFile,
    MessageStatus status
  ) {
    return _instance.ref("chats").child("$chatUid/messages").push().set({
      'message': msg,
      'messageDate': DateTime.now().toIso8601String(),
      'sentBy': sentBy,
      'sentTo': sentTo,
      'isAudio': isAudio,
      'isImage': isImage,
      'isFile': isFile,
      'status': status
    });
  }

  Future<void> updateUserStatus(
    String uid,
    String name,
    String? photoUrl,
    bool status,
    String? token,
  ) {
    return _instance.ref("status").child(uid).update({
      'name': name,
      'status': status,
      'photoUrl': photoUrl,
      'token': token,
    });
  }


  Future<void> updateMessageStatus(
    String chatUid,
    String messageId,
    MessageStatus status,
  ) {
    return _instance.ref("chats").child("$chatUid/messages").child(messageId).update({
      'status': status,
    });
  }

}
