
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:real_chat/src/packages/data/chat/chat.dart';

import '../../../../../core/ui/ui.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({
    super.key,
    required this.msg,
    required this.name,
    required this.photoUrl,
    required this.date,
    required this.mySelf,
    required this.status, // Añadir este campo
  });

  final String msg;
  final String name;
  final String? photoUrl;
  final DateTime date;
  final bool mySelf;
  final MessageStatus status; // Añadir este campo

  @override
  Widget build(BuildContext context) {
    final color = mySelf ? ChateoColors.primaryChat : ChateoColors.greyChat;
    final textColor = mySelf ? Colors.white : Colors.black;
    final maxWidth = MediaQuery.sizeOf(context).width * 0.6;
    final textTheme = Theme.of(context).textTheme;
    final formattedDate = DateFormat.jm().format(date);

    IconData statusIcon;
    Color statusColor;

    switch (status) {
      case MessageStatus.NotDelivered:
        statusIcon = Icons.check;
        statusColor = const Color.fromARGB(255, 255, 255, 255);
        break;
      case MessageStatus.Delivered:
        statusIcon = Icons.done_all;
        statusColor = const Color.fromARGB(255, 255, 255, 255);
        break;
      case MessageStatus.Read:
        statusIcon = Icons.done_all;
        statusColor = Color.fromARGB(255, 93, 189, 230);
        break;
    }

    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment:
          mySelf ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!mySelf)
          Padding(
            padding: const EdgeInsets.only(right: ChateoDimens.dimen_16),
            child: ChateoAvatar(
              name: name,
              photoUrl: photoUrl,
            ),
          ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment:
              mySelf ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              constraints: BoxConstraints(
                maxWidth: maxWidth,
              ),
              padding: const EdgeInsets.symmetric(
                vertical: ChateoDimens.dimen_8,
                horizontal: ChateoDimens.dimen_12,
              ),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.only(
                  topLeft: mySelf
                      ? const Radius.circular(ChateoDimens.dimen_12)
                      : Radius.zero,
                  topRight: mySelf
                      ? Radius.zero
                      : const Radius.circular(ChateoDimens.dimen_12),
                  bottomLeft: const Radius.circular(ChateoDimens.dimen_12),
                  bottomRight: const Radius.circular(ChateoDimens.dimen_12),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    msg,
                    style: textTheme.bodyMedium?.copyWith(
                      color: textColor,
                      fontSize: 14
                    ),
                    textAlign: mySelf ? TextAlign.right : TextAlign.left,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        formattedDate.toLowerCase(),
                        style: textTheme.labelSmall?.copyWith(
                          color: mySelf ? Colors.white : ChateoColors.darkGrey
                        ),
                        textAlign: mySelf ? TextAlign.right : TextAlign.left,
                      ),
                      if (mySelf) // Solo mostrar iconos de estado si es el propio mensaje
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Icon(
                            statusIcon,
                            size: 16,
                            color: statusColor,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: ChateoDimens.dimen_8,
            ),
          ],
        ),
      ],
    );
  }
}

