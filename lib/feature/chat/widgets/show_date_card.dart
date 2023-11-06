import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp_messenger/common/extentions/custom_theme_extention.dart';
import 'package:whatsapp_messenger/common/models/message_model.dart';

class ShowDateCard extends StatelessWidget {
  const ShowDateCard({
    super.key,
    required this.message,
  });

  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            color: context.theme.receiverChatCardBg,
            borderRadius: BorderRadius.circular(10)),
        child: Text(DateFormat.yMMMd().format(message.timeSent)));
  }
}
