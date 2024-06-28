import 'package:real_chat/src/app/navigator/app_navigator.dart';
import 'package:real_chat/src/packages/core/ui/ui.dart';
import 'package:real_chat/src/packages/data/chat/lib/src/domain/chat_user/chat_user.dart';
import 'package:flutter/material.dart';

class UserChatItem extends StatelessWidget {
  const UserChatItem({
    super.key,
    required this.chatUser,
    required this.myUid,
  });

  final ChatUser chatUser;
  final String myUid;

  @override
  Widget build(BuildContext context) {
    final _textTheme = Theme.of(context).textTheme;

    return ListTile(
      onTap: () => AppNavigator.navigateToChat(
        context,
        chatUser.uid,
        myUid,
        chatUser.name,
        chatUser.photoUrl,
        chatUser.status,
      ),
      leading: Stack(
        children: [
          ChateoAvatar(
            name: chatUser.name,
            photoUrl: chatUser.photoUrl,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: chatUser.status ? Colors.green : Colors.red,
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
              ),
            ),
          ),
        ],
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("10:00 am", style: _textTheme.titleSmall!.copyWith(color: Colors.black54, fontSize: 12),),
          SizedBox(height: 5,),
          Icon(Icons.check_circle_rounded, size: 18, color: Color.fromARGB(255, 63, 142, 233),)
        ],
      ),
      title: Text(
        chatUser.name,
        style: _textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      subtitle: Text(
        chatUser.status ? 'En línea' : 'Inactivo',
        style: TextStyle(
          color: ChateoColors.darkGrey,
        ),
      ),
    );
  }
}
