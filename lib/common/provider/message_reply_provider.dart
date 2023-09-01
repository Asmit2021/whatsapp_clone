import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/common/enums/message_enum.dart';

class MessageReply {
  final String message;
  final bool isMe;
  final MessageEnum messageEnum;

  MessageReply({
    this.message = '',
    this.isMe = false,
    this.messageEnum = MessageEnum.none,
  });
}

bool isReply = false;

class MessageReplyNotifier extends StateNotifier<MessageReply> {
  MessageReplyNotifier()
      : super(MessageReply(
            message: '', isMe: false, messageEnum: MessageEnum.none));

  void add(MessageReply messageReply) {
    state = messageReply;
  }
}

final messageReplyProvider =
    StateNotifierProvider<MessageReplyNotifier,MessageReply>((ref) => MessageReplyNotifier());

//final messageReplyProvider = StateProvider((ref) => null);
