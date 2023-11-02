import 'package:flutter/material.dart';
import 'package:whatsapp_messenger/common/extentions/custom_theme_extention.dart';
import 'package:whatsapp_messenger/common/utils/colors.dart';
import 'package:whatsapp_messenger/common/widgets/custom_icon_button.dart';

class ChatTextField extends StatefulWidget {
  const ChatTextField({super.key, required this.receiverId});
  final String receiverId;

  @override
  State<ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends State<ChatTextField> {
  late TextEditingController messageController;
  bool isMessageIconEnabled = false;

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
    return Padding(
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
                    onTap: () {},
                  ),
                ),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RotatedBox(
                      quarterTurns: 45,
                      child: CustomIconButton(
                        icon: Icons.attach_file,
                        onTap: () {},
                      ),
                    ),
                    CustomIconButton(
                      icon: Icons.camera_alt_outlined,
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
                    borderSide:
                        const BorderSide(style: BorderStyle.none, width: 0)),
                hintStyle: TextStyle(color: context.theme.greyColor)),
          )),
          const SizedBox(
            width: 5,
          ),
          CustomIconButton(
            onTap: () {},
            icon: isMessageIconEnabled
                ? Icons.send_rounded
                : Icons.mic_none_outlined,
            iconColor: Colors.white,
            background: AppColor.greenDark,
          )
        ],
      ),
    );
  }
}
