import 'package:flutter/material.dart';
import 'package:real_chat/src/packages/core/ui/lib/src/res/dimens.dart';

class ChateoAvatarProfile extends StatelessWidget {
  const ChateoAvatarProfile({
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
    final radius = this.radius ?? ChateoDimens.dimen_20;

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
