import 'package:flutter/material.dart';

import '../../../../../app/notification/push_message.dart';

class NotificationDetailPage extends StatelessWidget {
  const NotificationDetailPage({super.key, required this.pushMessageId});

  final String pushMessageId;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class DetailsView extends StatelessWidget {
  const DetailsView({super.key, required this.message});

  final PushMessage message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Column(
        children: [
          if(message.imageUrl != null)
          Image.network(message.imageUrl!),
          const SizedBox(height: 30,),
          Text(message.title, style: Theme.of(context).textTheme.labelMedium,),
          Text(message.body,),

          const Divider(),
          Text(message.data.toString(),)
        ],
      ),
    );
  }
}
