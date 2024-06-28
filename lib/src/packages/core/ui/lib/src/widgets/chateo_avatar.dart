import 'package:avatars/avatars.dart';
import 'package:flutter/material.dart';

import '../../../ui.dart';

class ChateoAvatar extends StatelessWidget {
  const ChateoAvatar({
    super.key,
    this.photoUrl,
    required this.name,
    this.radius,
  });

  final String? photoUrl;
  final String name;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    final radius = this.radius ?? ChateoDimens.dimen_24;

    return CircleAvatar(
      radius: radius,
      backgroundImage: photoUrl != null ? NetworkImage(photoUrl!) : null,
      child: photoUrl == null
          ? Text(
              name[0].toUpperCase(),
              style: TextStyle(fontSize: radius, color: Colors.white),
            )
          : null,
    );
  }
}
