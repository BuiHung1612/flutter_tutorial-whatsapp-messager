import 'dart:math';

import 'package:custom_clippers/custom_clippers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:whatsapp_messenger/common/extentions/custom_theme_extention.dart';
import 'package:whatsapp_messenger/common/helper/last_seen_message.dart';
import 'package:whatsapp_messenger/common/models/message_model.dart';
import 'package:whatsapp_messenger/common/models/user_modal.dart';
import 'package:whatsapp_messenger/common/routes/routes.dart';
import 'package:whatsapp_messenger/common/utils/colors.dart';
import 'package:whatsapp_messenger/common/widgets/custom_icon_button.dart';
import 'package:whatsapp_messenger/feature/auth/controller/auth_controller.dart';
import 'package:whatsapp_messenger/feature/chat/controllers/chat_controller.dart';
import 'package:whatsapp_messenger/feature/chat/widgets/chat_text_field.dart';
import 'package:whatsapp_messenger/feature/chat/widgets/message_card.dart';
import 'package:whatsapp_messenger/feature/chat/widgets/yellow_card.dart';

final pageStorageBucket = PageStorageBucket();

class ChatPage extends ConsumerWidget {
  ChatPage({super.key, required this.user});
  final UserModel user;
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: context.theme.chatPageBgColor,
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
            color: context.theme.chatPageDoodleColor,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 60),
            child: StreamBuilder(
              stream: ref
                  .read(chatControllerProvider)
                  .getAllOneToOneMessage(user.uid),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.active) {
                  return ListView.builder(
                      itemCount: 15,
                      itemBuilder: (contex, index) {
                        final random = Random().nextInt(14);
                        return Container(
                            alignment: random.isEven
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            margin: EdgeInsets.only(
                              top: 5,
                              bottom: 5,
                              left: random.isEven ? 150 : 15,
                              right: random.isEven ? 15 : 150,
                            ),
                            child: ClipPath(
                              clipper: UpperNipMessageClipperTwo(
                                  random.isEven
                                      ? MessageType.send
                                      : MessageType.receive,
                                  nipHeight: 8,
                                  nipWidth: 6,
                                  bubbleRadius: 12),
                              child: Shimmer.fromColors(
                                  baseColor: random.isEven
                                      ? context.theme.greyColor!.withOpacity(.3)
                                      : context.theme.greyColor!
                                          .withOpacity(.2),
                                  highlightColor: random.isEven
                                      ? context.theme.greyColor!.withOpacity(.4)
                                      : context.theme.greyColor!
                                          .withOpacity(.3),
                                  child: Container(
                                    color: Colors.red,
                                    width: 180 +
                                        double.parse((random * 2).toString()),
                                    height: 40,
                                  )),
                            ));
                      });
                }
                return PageStorage(
                  bucket: pageStorageBucket,
                  child: ListView.builder(
                      key: const PageStorageKey("chat_page_list"),
                      controller: scrollController,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final message = snapshot.data![index];
                        final isSender = message.senderId ==
                            FirebaseAuth.instance.currentUser!.uid;

                        final haveNip = (index == 0) ||
                            (index == snapshot.data!.length - 1 &&
                                message.senderId !=
                                    snapshot.data![index - 1].senderId) ||
                            (message.senderId !=
                                    snapshot.data![index - 1].senderId &&
                                message.senderId ==
                                    snapshot.data![index + 1].senderId) ||
                            (message.senderId !=
                                    snapshot.data![index - 1].senderId &&
                                message.senderId ==
                                    snapshot.data![index + 1].senderId);
                        return Column(
                          children: [
                            if (index == 0) const YellowCard(),
                            MessageCard(
                                isSender: isSender,
                                haveNip: haveNip,
                                message: message),
                          ],
                        );
                      }),
                );
              },
            ),
          ),
          Container(
            alignment: const Alignment(0, 1),
            child: ChatTextField(
                receiverId: user.uid, scrollController: scrollController),
          )
        ]),
      ),
    );
  }
}
