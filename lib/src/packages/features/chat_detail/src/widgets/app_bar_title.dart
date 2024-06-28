import 'package:flutter/material.dart';

import '../../../../core/ui/ui.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({
    super.key,
    required this.userChatName,
    required this.userChatPhotoUrl,
    required this.userChatStatus,
    required this.textTheme,
  });

  final String userChatName;
  final String? userChatPhotoUrl;
  final bool userChatStatus;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Row(

      children: [
        Stack(
          children: [
            ChateoAvatarProfile(
              name: userChatName,
              photoUrl: userChatPhotoUrl,
            ),
            Positioned(
              right: 0,
              bottom: 0,
              
              child: SizedBox(
                width: ChateoDimens.dimen_12,
                height: ChateoDimens.dimen_12,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: userChatStatus ? Colors.green : Colors.red,
                  ),
                ),
              ),
            ),
          ],
        ),
        Flexible(
          child: ListTile(
            title: Text(
              userChatName,
              style: textTheme.titleMedium,
            ),
            subtitle: Text(
              userChatStatus ? 'En línea' : 'Inactivo',
              style: textTheme.bodySmall,
            ),
            trailing: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                  child: IconButton(
                    icon: Icon(Icons.call_outlined, color: ChateoColors.darkGrey, size: 25, ),
                    onPressed: () {
                      // Lógica para realizar una llamada
                    },
                  ),
                ),

              ],
            ),
          ),
        )
      ],
    );
  }
}
