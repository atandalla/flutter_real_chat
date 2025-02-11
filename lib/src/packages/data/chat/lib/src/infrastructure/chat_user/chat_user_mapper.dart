
import '../../../../chat.dart';

class ChatUserMapper {
  const ChatUserMapper();

  ChatUser fromApiChatUserDto(ChatUserDto dto) {
    final uid = dto.uid;
    final name = dto.name;
    final photoUrl = dto.photoUrl;
    final status = dto.status;

    return ChatUser(
      uid: uid,
      name: name,
      status: status,
      photoUrl: photoUrl,
    );
  }

  List<ChatUser> fromApiChatUserDtoList(List<ChatUserDto> dtos) =>
      dtos.map((dto) => fromApiChatUserDto(dto)).toList();
}
