import 'package:chat_app/core/const.dart';
import 'package:chat_app/model/message.dart';
import 'package:flutter/material.dart';

class ChatController {

  Future<void> sendMessage(Message message) async {
    chatMessages.add(message);
  }

  void scrollToBottom(ScrollController scrollController) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 150),
          curve: Curves.easeOut,
        );
      }
    });
  }
}