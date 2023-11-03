import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp_messenger/common/extentions/custom_theme_extention.dart';
import 'package:whatsapp_messenger/common/models/user_modal.dart';
import 'package:whatsapp_messenger/common/routes/routes.dart';
import 'package:whatsapp_messenger/common/utils/colors.dart';
import 'package:whatsapp_messenger/feature/chat/controllers/chat_controller.dart';

class ChatHomePage extends ConsumerWidget {
  const ChatHomePage({super.key});

  navigateToContactPage(context) {
    Navigator.pushNamed(context, Routes.contact);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: StreamBuilder(
        stream: ref.watch(chatControllerProvider).getAllLastMessageList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColor.greenDark,
              ),
            );
          }
          return ListView.builder(
              itemCount: snapshot.data!.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final lastMessageData = snapshot.data![index];
                return ListTile(
                  onTap: () => Navigator.pushNamed(context, Routes.chat,
                      arguments: UserModel(
                          username: lastMessageData.username,
                          uid: lastMessageData.contactId,
                          avatarUrl: lastMessageData.avatarUrl,
                          active: true,
                          phoneNumber: '',
                          groupId: [],
                          lastSeen: 0)),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(lastMessageData.username),
                      Text(
                        DateFormat.Hm().format(lastMessageData.timeSent),
                        style: TextStyle(
                            fontSize: 13, color: context.theme.greyColor),
                      )
                    ],
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 3),
                    child: Text(
                      lastMessageData.lastMessage,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: context.theme.greyColor),
                    ),
                  ),
                  leading: CircleAvatar(
                      backgroundImage: NetworkImage(lastMessageData.avatarUrl)),
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => navigateToContactPage(context),
        child: const Icon(Icons.chat),
      ),
    );
  }
}
