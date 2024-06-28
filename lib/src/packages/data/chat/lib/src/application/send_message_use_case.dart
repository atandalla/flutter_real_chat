
import '../../../chat.dart';

class SendMessageUseCase {
  final MessageRepository _messageRepository;

  const SendMessageUseCase(this._messageRepository);

  Future<void> call(
    String chatUid,
    String msg,
    String sentBy,
    String sentTo,
    bool isAudio,
    bool isImage,
    bool isFile,
    MessageStatus status
    
  ) =>
      _messageRepository.sendMessage(
        chatUid,
        msg,
        sentBy,
        sentTo,
        isAudio,
        isImage,
        isFile,
        status
      );

    
      
}
