
import '../../../chat.dart';

class UpdateUserStatusUseCase {
  final ChatUserRepository _chatUserRepository;

  const UpdateUserStatusUseCase(this._chatUserRepository);

  Future<void> call(
    String uid,
    String name,
    String? photoUrl,
    bool status,
    String? token,
  ) =>
      _chatUserRepository.updateById(
        uid,
        name,
        photoUrl,
        status,
        token,
      );
}
