import 'package:chat_app/widgets/chat_appbar.dart';
import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';

import '../core/const.dart';
import '../logic/chat_controller.dart';
import '../model/message.dart';

class Chat1Screen extends StatefulWidget {
  final String chatName;
  const Chat1Screen({super.key, required this.chatName});

  @override
  State<Chat1Screen> createState() => _Chat1ScreenState();
}

class _Chat1ScreenState extends State<Chat1Screen> {
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
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset('assets/images/spiderman.jpg', fit: BoxFit.cover),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: ChatAppbar(title: 'Chat 1'),
          body: SizedBox(
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: chatMessages.length,
                    itemBuilder: (context, i) {
                      return BubbleSpecialThree(
                        text: chatMessages[i].message,
                        color: chatMessages[i].sender == widget.chatName
                            ? Color(0xFF1B97F3)
                            : Color(0xFF7B7B7B),
                        tail: true,
                        isSender: chatMessages[i].sender == widget.chatName,
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                    top: 4,
                    bottom: 10,
                    left: 12,
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
                          Message message = Message(
                            message: messageController.text,
                            sender: widget.chatName,
                          );
                          await controller.sendMessage(message);
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
        ),
      ],
    );
  }
}
