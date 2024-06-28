import 'package:real_chat/src/packages/data/chat/chat.dart';

class UpdateMessageStatusUseCase {
  final MessageRepository _messageRepository;

  const UpdateMessageStatusUseCase(this._messageRepository);

  Future<void> call(
    String chatUid,
    String messageId,
    MessageStatus status,
  ) =>
      _messageRepository.updateMessageStatusById(
        chatUid,
        messageId,
        status,
      );
}
