import 'package:flutter/material.dart';
import 'package:whatsapp_messenger/common/extentions/custom_theme_extention.dart';
import 'package:whatsapp_messenger/common/models/user_modal.dart';
import 'package:whatsapp_messenger/common/utils/colors.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({
    super.key,
    required this.contactSource,
    this.onTap,
  });
  final VoidCallback? onTap;
  final UserModel contactSource;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.only(
        left: 20,
        right: 10,
      ),
      leading: CircleAvatar(
          backgroundImage: contactSource.avatarUrl.isNotEmpty
              ? NetworkImage(contactSource.avatarUrl)
              : null,
          backgroundColor: context.theme.greyColor!.withOpacity(0.3),
          radius: 20,
          child: contactSource.avatarUrl.isEmpty
              ? const Icon(
                  Icons.person,
                  size: 30,
                )
              : null),
      title: Text(
        contactSource.username,
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: context.theme.greyColor),
      ),
      subtitle: contactSource.avatarUrl.isEmpty
          ? null
          : Text(
              "Hey there! I'm using WhatsApp",
              style: TextStyle(
                  color: context.theme.greyColor, fontWeight: FontWeight.w600),
            ),
      trailing: contactSource.avatarUrl.isEmpty
          ? TextButton(
              onPressed: onTap,
              style: TextButton.styleFrom(foregroundColor: AppColor.greenDark),
              child: const Text("INVATE"),
            )
          : null,
    );
  }
}
