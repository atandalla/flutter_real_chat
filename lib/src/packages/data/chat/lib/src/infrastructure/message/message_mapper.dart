
import '../../../../chat.dart';

class MessageMapper {
  const MessageMapper();

  Message fromApiChatUserDto(MessageDto dto) {
    final id = dto.uid;
    final msg = dto.msg;
    final date = dto.date;
    final sentBy = dto.sentBy;
    final isAudio = dto.isAudio;
    final isImage = dto.isImage;
    final isFile = dto.isFile;
    final status = dto.status;

    return Message(
      id: id,
      msg: msg,
      date: DateTime.parse(date),
      sentBy: sentBy,
      isAudio: isAudio,
      isImage: isImage,
      isFile: isFile,
      status: status
    );
  }

  List<Message> fromApiChatUserDtoList(List<MessageDto> dtos) =>
      dtos.map((dto) => fromApiChatUserDto(dto)).toList();
}
