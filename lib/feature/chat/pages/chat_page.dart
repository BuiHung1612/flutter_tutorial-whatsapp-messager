import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_messenger/common/extentions/custom_theme_extention.dart';
import 'package:whatsapp_messenger/common/helper/last_seen_message.dart';
import 'package:whatsapp_messenger/common/models/user_modal.dart';
import 'package:whatsapp_messenger/common/routes/routes.dart';
import 'package:whatsapp_messenger/common/widgets/custom_icon_button.dart';
import 'package:whatsapp_messenger/feature/auth/controller/auth_controller.dart';
import 'package:whatsapp_messenger/feature/chat/widgets/chat_text_field.dart';

class ChatPage extends ConsumerWidget {
  const ChatPage({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: InkWell(
          onTap: () =>
              Navigator.pushNamed(context, Routes.profile, arguments: user),
          child: Container(
            alignment: Alignment.topLeft,
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Hero(
                tag: 'profile',
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(user.avatarUrl),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.username,
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  // const Text(
                  //   "Last seen 2 min ago",
                  //   style: TextStyle(fontSize: 12, color: Colors.white),
                  // )
                  StreamBuilder(
                      stream: ref
                          .read(authControllerProvider)
                          .getUserPresenceStatus(uid: user.uid),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState !=
                            ConnectionState.active) {
                          return const Text(
                            "connecting",
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          );
                        }
                        return Text(
                          snapshot.data!.active
                              ? "Online"
                              : "${lastSeenMessage(snapshot.data!.lastSeen)} ago",
                          style: const TextStyle(
                              fontSize: 12, color: Colors.white),
                        );
                      })
                ],
              ),
            ]),
          ),
        ),
        actions: [
          CustomIconButton(
            onTap: () {},
            icon: Icons.video_call,
            iconColor: Colors.white,
          ),
          CustomIconButton(
              onTap: () {}, icon: Icons.call, iconColor: Colors.white),
          CustomIconButton(
              onTap: () {}, icon: Icons.more_vert, iconColor: Colors.white)
        ],
      ),
      body: SafeArea(
        child: Stack(children: [
          Image(
            image: const AssetImage('assets/images/doodle_bg.png'),
            width: double.maxFinite,
            height: double.maxFinite,
            fit: BoxFit.cover,
            color: context.theme.photoIconBgColor,
          ),
          Column(
            children: [
              Expanded(child: Container()),
              ChatTextField(receiverId: user.uid)
            ],
          )
        ]),
      ),
    );
  }
}
