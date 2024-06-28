
import 'package:flutter/material.dart';

import 'package:flutter/scheduler.dart';

import '../../../../core/ui/ui.dart';
import '../../../../data/chat/chat.dart';
import 'messages/messages.dart';


class ChatContent extends StatelessWidget {
  const ChatContent({
    super.key,
    required this.messages,
    required this.myUid,
    required this.name,
    required this.photoUrl,
  });

  final List<Message> messages;
  final String myUid;
  final String name;
  final String? photoUrl;

  @override
  Widget build(BuildContext context) {
    final listController = ScrollController();
    scroll(listController);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: ChateoDimens.dimen_12),
        child: ListView.builder(
          controller: listController,
          padding: const EdgeInsets.only(bottom: ChateoDimens.dimen_60),
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final message = messages[index];
            if (message.isAudio) {
              return AudioMessageWidget(
                audioUrl: message.msg,
                date: message.date,
                mySelf: message.sentBy == myUid,
                name: name,
                photoUrl: photoUrl,
              );
            } else if (message.isImage) {
              return ImageMessageWidget(
                imageUrl: message.msg,
                date: message.date,
                mySelf: message.sentBy == myUid,
                name: name,
                photoUrl: photoUrl,
              );
            } else if (message.isFile) {
              return FileMessageWidget(
                fileUrl: message.msg,
                date: message.date,
                mySelf: message.sentBy == myUid,
                name: name,
                photoUrl: photoUrl,
              );
            } else {
              return MessageWidget(
                msg: message.msg,
                date: message.date,
                mySelf: message.sentBy == myUid,
                name: name,
                photoUrl: photoUrl,
                status: message.status,
              );
            }
          },
        ),
      ),
    );
  }

  void scroll(ScrollController listController) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      listController.animateTo(
        listController.position.maxScrollExtent,
        duration: const Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      );
    });
  }
}



// class ChatContent extends StatelessWidget {
//   const ChatContent({
//     super.key,
//     required this.messages,
//     required this.myUid,
//     required this.name,
//     required this.photoUrl,
//   });

//   final List<Message> messages;
//   final String myUid;
//   final String name;
//   final String? photoUrl;

//   @override
//   Widget build(BuildContext context) {
//     final listController = ScrollController();
//     scroll(listController);

//     return SafeArea(
//       child: ListView.builder(
//         controller: listController,
//         padding: const EdgeInsets.only(bottom: ChateoDimens.dimen_60),
//         itemCount: messages.length,
//         itemBuilder: (context, index) => MessageWidget(
//           msg: messages[index].msg,
//           date: messages[index].date,
//           mySelf: messages[index].sentBy == myUid,
//           name: name,
//           photoUrl: photoUrl,
//         ),
//       ),
//     );
//   }

//   void scroll(ScrollController listController) {
//     SchedulerBinding.instance.addPostFrameCallback((_) {
//       listController.animateTo(
//         listController.position.maxScrollExtent,
//         duration: const Duration(seconds: 1),
//         curve: Curves.fastOutSlowIn,
//       );
//     });
//   }
// }
