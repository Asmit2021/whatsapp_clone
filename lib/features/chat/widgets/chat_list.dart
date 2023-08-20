import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:whatsapp_clone/features/chat/controller/chat_controller.dart';
import 'package:whatsapp_clone/info.dart';
import 'package:whatsapp_clone/widgets/my_message_card.dart';
import 'package:whatsapp_clone/widgets/sender_message_card.dart';

class ChatList extends ConsumerWidget {
  final String recieverUserId;
  const ChatList({
    super.key, 
    required this.recieverUserId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<Object>(
        stream: ref.read(chatControllerProvider).chatStream(recieverUserId),
        builder: (context, snapshot) {
          return ListView.builder(
              itemCount: messages.length,
              itemBuilder: (contxt, index) {
                if (messages[index]['isMe'] == true) {
                  return MyMessageCard(
                    message: messages[index]['text'].toString(),
                    date: messages[index]['time'].toString(),
                  );
                }
                return SenderMessageCard(
                  message: messages[index]['text'].toString(),
                  date: messages[index]['time'].toString(),
                );
                // SenderMessage ->card
              });
        });
  }
}