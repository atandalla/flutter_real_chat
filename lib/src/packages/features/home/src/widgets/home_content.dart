import 'package:real_chat/src/app/navigator/app_navigator.dart';
import 'package:real_chat/src/packages/core/ui/ui.dart';
import 'package:real_chat/src/packages/data/account/account.dart';
import 'package:real_chat/src/packages/features/home/src/widgets/user_chats_list.dart';
import 'package:flutter/material.dart';

import '../../../../data/chat/chat.dart';

import 'package:flutter/material.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({
    Key? key,
    required this.chats,
    required this.user,
  }) : super(key: key);

  final List<ChatUser> chats;
  final User user;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return DefaultTabController(
      length: 2,
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: ChateoDimens.dimen_32, vertical: ChateoDimens.dimen_8),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.search,
                      ),
                    ),
                  ),
                  Text(
                    'ZeroChat',
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => AppNavigator.navigateToProfile(context),
                      child: Hero(
                        tag: user.uid,
                        child: ChateoAvatarProfile(
                          name: user.name ?? '',
                          photoUrl: user.photoUrl,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            TabBar(
              
              labelStyle: textTheme.titleSmall!.copyWith( color: ChateoColors.primary ,fontSize: 14),
              unselectedLabelStyle: textTheme.titleSmall!.copyWith( color: ChateoColors.darkGrey ,fontSize: 14 ),
              tabs: const [
                Tab(text: 'Chat Empresarial',),
                Tab(text: 'ZeroChat'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  UserChatsList(
                    chats: chats,
                    myUid: user.uid,
                  ),
                  ChatBotScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatBotScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: ChateoDimens.dimen_32, vertical: ChateoDimens.dimen_32),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/images/img_bot.png'), // Replace with your chatbot image
          ),
          SizedBox(height: 16),
          Text(
            'Asistente Virtual',
            style: textTheme.headline5?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Estoy aquí para ayudarte',
            style: textTheme.subtitle1?.copyWith(color: Colors.black54),
          ),
          SizedBox(height: 16),
          Wrap(
            spacing: 8.0,
            children: [
              ActionChip(
                avatar: Icon(Icons.search, color: Colors.blue),
                label: Text('Consultar'),
                onPressed: () {
                  // Implement your logic here
                },
              ),
              ActionChip(
                avatar: Icon(Icons.lightbulb, color: Colors.green),
                label: Text('Sugerencias'),
                onPressed: () {
                  // Implement your logic here
                },
              ),
              ActionChip(
                avatar: Icon(Icons.shopping_cart, color: Colors.red),
                label: Text('Comprar'),
                onPressed: () {
                  // Implement your logic here
                },
              ),
            ],
          ),
          SizedBox(height: 32),
          Expanded(
            child: ListView(
              children: [
                ChatBotSuggestionCard(
                  suggestion: '¿Cómo puedo ayudarte hoy?',
                  onTap: () {
                    // Implement your logic here
                  },
                ),
                ChatBotSuggestionCard(
                  suggestion: '¿Tienes alguna pregunta?',
                  onTap: () {
                    // Implement your logic here
                  },
                ),
                // Add more suggestions as needed
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBotSuggestionCard extends StatelessWidget {
  final String suggestion;
  final VoidCallback onTap;

  const ChatBotSuggestionCard({
    Key? key,
    required this.suggestion,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(suggestion),
        trailing: Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
