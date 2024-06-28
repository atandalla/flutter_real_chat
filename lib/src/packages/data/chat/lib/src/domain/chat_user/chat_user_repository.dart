
import '../../../../chat.dart';

abstract class ChatUserRepository {
  Stream<List<ChatUser>> findAll();

  Future<void> updateById(
    String uid,
    String name,
    String? photoUrl,
    bool status,
    String? token,
  );
}
