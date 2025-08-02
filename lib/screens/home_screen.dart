import 'package:flutter/material.dart';

import '../widgets/chat_appbar.dart';
import '../widgets/chat_item.dart';
import 'chat1_screen.dart';
import 'chat2_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatAppbar(title: 'Home Screen'),
      body: Container(
        padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
        // child: ListView.separated(
        //   separatorBuilder: (_, _) => const SizedBox(height: 8),
        //   itemCount: 2,
        //   itemBuilder: (context, i) {
        //     return ChatItem();
        //   },
        // )
        child: Column(
          children: [
            ChatItem(
              chatName: 'Chat 1',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const Chat1Screen(chatName: 'Chat 1'),
                  ),
                );
              },
            ),
            const Divider(),
            ChatItem(
              chatName: 'Chat 2',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const Chat2Screen(chatName: 'Chat 2'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
