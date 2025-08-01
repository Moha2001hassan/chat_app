import 'package:chat_app/widgets/chat_appbar.dart';
import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';

import '../core/const.dart';
import '../logic/chat_controller.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final ChatController controller;
  late final TextEditingController messageController;
  late final ScrollController scrollController;

  @override
  void initState() {
    controller = ChatController();
    messageController = TextEditingController();
    scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatAppbar(),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/spiderman.jpg', fit: BoxFit.cover),
          ),
          SizedBox(
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: chatMessages.length,
                    itemBuilder: (context, i) {
                      return BubbleSpecialThree(
                        text: chatMessages[i],
                        color: Color(0xFF1B97F3),
                        tail: true,
                        isSender: true,
                        textStyle: TextStyle(color: Colors.white, fontSize: 16),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: messageController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Type a message',
                          ),
                          maxLines: null,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.send, color: Colors.blue),
                        onPressed: () async {
                          await controller.sendMessage(messageController.text);
                          messageController.clear();
                          setState(() {});
                          controller.scrollToBottom(scrollController);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
