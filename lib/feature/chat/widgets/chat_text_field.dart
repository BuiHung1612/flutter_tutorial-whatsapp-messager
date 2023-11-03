import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_messenger/common/extentions/custom_theme_extention.dart';
import 'package:whatsapp_messenger/common/utils/colors.dart';
import 'package:whatsapp_messenger/common/widgets/custom_icon_button.dart';
import 'package:whatsapp_messenger/feature/chat/controllers/chat_controller.dart';

class ChatTextField extends ConsumerStatefulWidget {
  const ChatTextField(
      {super.key, required this.receiverId, required this.scrollController});
  final String receiverId;
  final ScrollController scrollController;

  @override
  ConsumerState<ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends ConsumerState<ChatTextField> {
  late TextEditingController messageController;
  bool isMessageIconEnabled = false;
  double cardHeight = 0;

  void sendTextMessage() async {
    if (isMessageIconEnabled) {
      ref.read(chatControllerProvider).sendTextMessage(
          context: context,
          textMessage: messageController.text,
          receiverId: widget.receiverId);

      messageController.clear();
    }

    await Future.delayed(const Duration(milliseconds: 100));
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      widget.scrollController.animateTo(
          widget.scrollController.position.maxScrollExtent + 50,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut);
    });
  }

  iconWithText(
      {required VoidCallback onTap,
      required IconData icon,
      required String text,
      required Color background}) {
    return Column(
      children: [
        CustomIconButton(
          onTap: onTap,
          icon: icon,
          background: background,
          minWidth: 50,
          iconColor: Colors.white,
          border: Border.all(
              color: context.theme.greyColor!.withOpacity(0.2), width: 1),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          text,
          style: TextStyle(color: context.theme.greyColor),
        )
      ],
    );
  }

  @override
  void initState() {
    messageController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: cardHeight,
          width: double.maxFinite,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              color: context.theme.receiverChatCardBg,
              borderRadius: BorderRadius.circular(20)),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      iconWithText(
                          onTap: () {},
                          icon: Icons.book,
                          text: "File",
                          background: const Color(0xFFF96533)),
                      iconWithText(
                          onTap: () {},
                          icon: Icons.camera_alt,
                          text: "Camera",
                          background: const Color(0xFF1FA855)),
                      iconWithText(
                          onTap: () {},
                          icon: Icons.photo,
                          text: "Gallery",
                          background: const Color(0xFF009DE1))
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      iconWithText(
                          onTap: () {},
                          icon: Icons.headphones,
                          text: "Audio",
                          background: const Color(0xFF7F66FE)),
                      iconWithText(
                          onTap: () {},
                          icon: Icons.location_on,
                          text: "Location",
                          background: const Color(0xFFFE2E74)),
                      iconWithText(
                          onTap: () {},
                          icon: Icons.person,
                          text: "Person",
                          background: const Color(0xFFC861F9))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              Expanded(
                  child: TextFormField(
                controller: messageController,
                maxLines: 4,
                minLines: 1,
                autofocus: true,
                onChanged: (value) {
                  value.isEmpty
                      ? setState(() => isMessageIconEnabled = false)
                      : setState(() => isMessageIconEnabled = true);
                },
                decoration: InputDecoration(
                    prefixIcon: Material(
                      color: Colors.transparent,
                      child: CustomIconButton(
                        icon: Icons.emoji_emotions_outlined,
                        iconColor: Theme.of(context).listTileTheme.iconColor,
                        onTap: () {},
                      ),
                    ),
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        RotatedBox(
                          quarterTurns: 45,
                          child: CustomIconButton(
                            icon: cardHeight == 0
                                ? Icons.attach_file
                                : Icons.close,
                            iconColor:
                                Theme.of(context).listTileTheme.iconColor,
                            onTap: () {
                              setState(() => cardHeight == 0
                                  ? cardHeight = 220
                                  : cardHeight = 0);
                            },
                          ),
                        ),
                        CustomIconButton(
                          icon: Icons.camera_alt_outlined,
                          iconColor: Theme.of(context).listTileTheme.iconColor,
                          onTap: () {},
                        )
                      ],
                    ),
                    fillColor: context.theme.chatTextFieldBg,
                    filled: true,
                    hintText: "Message",
                    isDense: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                            style: BorderStyle.none, width: 0)),
                    hintStyle: TextStyle(color: context.theme.greyColor)),
              )),
              const SizedBox(
                width: 5,
              ),
              CustomIconButton(
                onTap: sendTextMessage,
                icon: isMessageIconEnabled
                    ? Icons.send_rounded
                    : Icons.mic_none_outlined,
                iconColor: Colors.white,
                background: AppColor.greenDark,
              )
            ],
          ),
        ),
      ],
    );
  }
}
