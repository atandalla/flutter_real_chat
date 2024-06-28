

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:real_chat/src/packages/core/ui/ui.dart';

class ImageMessageWidget extends StatelessWidget {
  const ImageMessageWidget({
    Key? key,
    required this.imageUrl,
    required this.date,
    required this.mySelf,
    required this.name,
    required this.photoUrl
  }) : super(key: key);

  final String imageUrl;
  final DateTime date;
  final bool mySelf;
  final String name;
  final String? photoUrl;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final formattedDate = DateFormat.jm().format(date);

    return Row(
      mainAxisAlignment: mySelf ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!mySelf)
          Padding(
            padding: const EdgeInsets.only(right: ChateoDimens.dimen_20),
            child: ChateoAvatar(
              name: name,
              photoUrl: photoUrl,
            ),
          ),
        Column(
          crossAxisAlignment: mySelf ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.symmetric(vertical: 4.0),
              decoration: BoxDecoration(
                color: mySelf ? ChateoColors.primary : Colors.grey[300],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    color: Colors.grey[300],
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      formattedDate.toLowerCase(),
                      style: textTheme.labelSmall?.copyWith(
                        color: mySelf ? Colors.white : ChateoColors.darkGrey,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
