
import '../../../chat.dart';

class GetChatUsersUseCase {
  final ChatUserRepository _chatUserRepository;

  const GetChatUsersUseCase(this._chatUserRepository);

  Stream<List<ChatUser>> call() => _chatUserRepository.findAll();
}
