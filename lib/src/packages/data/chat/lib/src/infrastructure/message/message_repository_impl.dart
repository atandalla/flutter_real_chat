
import '../../../../chat.dart';

class MessageRepositoryImpl extends MessageRepository {
  final ChatApiClient _chatApiClient;
  final MessageMapper _messageMapper;

  MessageRepositoryImpl(
    this._chatApiClient,
    this._messageMapper,
  );

  @override
  Stream<List<Message>> findAll(String chatId) => _chatApiClient
      .getChat(chatId)
      .map((dtos) => _messageMapper.fromApiChatUserDtoList(dtos));

  @override
  Future<void> sendMessage(

    String chatUid,
    String msg,
    String sentBy,
    String sentTo,
    bool isAudio,
    bool isImage,
    bool isFile,
    MessageStatus status

  ) =>
      _chatApiClient.sendMessage(
        chatUid,
        msg,
        sentBy,
        sentTo,
        isAudio,
        isImage,
        isFile,
        status
      );
      
  @override
  Future<void> updateMessageStatusById(
    String uid, 
    String name, 
    MessageStatus status, 
    ) => _chatApiClient.updateMessageStatus(
      uid,
      name,
      status
    );
}
