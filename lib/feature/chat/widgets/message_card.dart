import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_messenger/common/enum/message_type.dart'
    as myMessageType;
import 'package:whatsapp_messenger/common/extentions/custom_theme_extention.dart';
import 'package:whatsapp_messenger/common/models/message_model.dart';

class MessageCard extends StatelessWidget {
  const MessageCard({
    super.key,
    required this.isSender,
    required this.haveNip,
    required this.message,
  });

  final bool isSender;
  final bool haveNip;
  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
        margin: EdgeInsets.only(
            top: 4,
            bottom: 4,
            left: isSender
                ? 80
                : haveNip
                    ? 10
                    : 15,
            right: isSender
                ? haveNip
                    ? 10
                    : 15
                : 80),
        child: ClipPath(
          clipper: haveNip
              ? UpperNipMessageClipperTwo(
                  isSender ? MessageType.send : MessageType.receive,
                  nipHeight: 8,
                  nipWidth: 6,
                  bubbleRadius: 12)
              : null,
          child: Container(
              padding: EdgeInsets.only(
                  top: 8,
                  bottom: 8,
                  left: isSender ? 10 : 15,
                  right: isSender ? 15 : 10),
              decoration: BoxDecoration(
                color: isSender
                    ? context.theme.senderChatCardBg
                    : context.theme.receiverChatCardBg,
                borderRadius: haveNip ? null : BorderRadius.circular(12),
                boxShadow: const [BoxShadow(color: Colors.black38)],
              ),
              child: Column(
                crossAxisAlignment: isSender
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  message.type == myMessageType.MessageType.image
                      ? Image.network(
                          message.textMessage,
                          fit: BoxFit.cover,
                        )
                      : Text(
                          message.textMessage,
                          style: const TextStyle(fontSize: 16),
                        ),
                ],
              )),
        ));
  }
}
