import 'package:flutter/material.dart';

class ChatItem extends StatelessWidget {
  final String chatName;
  final VoidCallback onTap;

  const ChatItem({super.key, required this.chatName, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Row(
          children: [
            CircleAvatar(radius: 28, backgroundColor: Colors.blue),
            const SizedBox(width: 12),
            Text(
              chatName,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
