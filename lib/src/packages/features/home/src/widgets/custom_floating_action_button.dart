
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';

class AnimatedCreateNewChatButton extends StatelessWidget {
  const AnimatedCreateNewChatButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ExpandableFab(
      
      distance: 80,
      
      children: [
        CustomFloatActionButton (
          buttonIcon: Icons.groups_3_rounded,
          isCreateNewChatPageForCreatingGroup: true,
        ),
        CustomFloatActionButton(
          buttonIcon: Icons.person_rounded,
          isCreateNewChatPageForCreatingGroup: false,
        ),
      ],
      //child: const Icon(CupertinoIcons.chat_bubble_text),
    );
  }
}



class CustomFloatActionButton extends StatelessWidget {
  const CustomFloatActionButton({
    super.key,
    required this.buttonIcon,
    required this.isCreateNewChatPageForCreatingGroup,
  });

  final IconData buttonIcon;
  final bool isCreateNewChatPageForCreatingGroup;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(

      heroTag: null,
      onPressed: () {
        // context.go(
        //   context.namedLocation("create_new_chat_page"),
        //   extra: {
        //     "userListController": userListController,
        //     "isCreateNewChatPageForCreatingGroup": isCreateNewChatPageForCreatingGroup
        //   },
        // );
      },
      child: Icon(buttonIcon),
    );
  }
}
