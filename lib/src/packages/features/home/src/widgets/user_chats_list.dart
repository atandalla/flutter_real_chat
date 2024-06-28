import 'package:real_chat/src/packages/core/ui/ui.dart';
import 'package:real_chat/src/packages/features/home/src/widgets/user_chat_item.dart';
import 'package:flutter/material.dart';

import '../../../../data/chat/chat.dart';

class UserChatsList extends StatelessWidget {
  const UserChatsList({
    super.key,
    required this.chats,
    required this.myUid,
  });

  final List<ChatUser> chats;
  final String myUid;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 0.8;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: ChateoDimens.dimen_12,
        horizontal: ChateoDimens.dimen_4,
      ),
      height: height,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(ChateoDimens.dimen_40),
            topRight: Radius.circular(ChateoDimens.dimen_40),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Flexible(
            child: ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) => UserChatItem(
                chatUser: chats[index],
                myUid: myUid,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
