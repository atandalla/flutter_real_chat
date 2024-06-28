
import '../../../chat.dart';

class GetChatUseCase {
  final MessageRepository _messageRepository;

  const GetChatUseCase(this._messageRepository);

  Stream<List<Message>> call(String chatId) =>
      _messageRepository.findAll(chatId);

 
  Future<Message?> getLastMessage(String chatId) async {
    final messages = await _messageRepository.findAll(chatId).first;
    if (messages.isNotEmpty) {
      return messages.last;
    }
    return null;
  }
}
