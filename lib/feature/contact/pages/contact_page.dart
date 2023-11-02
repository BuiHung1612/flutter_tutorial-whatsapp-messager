import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_messenger/common/extentions/custom_theme_extention.dart';
import 'package:whatsapp_messenger/common/helper/show_alert_dialog.dart';
import 'package:whatsapp_messenger/common/models/user_modal.dart';
import 'package:whatsapp_messenger/common/routes/routes.dart';
import 'package:whatsapp_messenger/common/utils/colors.dart';
import 'package:whatsapp_messenger/common/widgets/custom_icon_button.dart';
import 'package:whatsapp_messenger/feature/contact/controller/contacts_controller.dart';
import 'package:whatsapp_messenger/feature/contact/widgets/contact_card.dart';

class ContactPage extends ConsumerWidget {
  const ContactPage({super.key});

  shareSmsLink(String phoneNumber, BuildContext context) async {
    Uri sms = Uri.parse(
        "sms:${Platform.isAndroid ? phoneNumber : phoneNumber.replaceAll(' ', '-').replaceAll('+', '')}${Platform.isAndroid ? "?" : "&"}body=Let's chat on WhatsApp! it's a fast, simple, and secure app we can call each other for free. Get it at https://whatsappme.com/dl/");
    try {
      await launchUrl(sms);
    } catch (e) {
      if (context.mounted) {
        showAlertDialog(context: context, message: e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            "Select contact",
            style: TextStyle(color: Colors.white),
          ),
          const SizedBox(
            height: 3,
          ),
          ref.watch(contactControllerProvider).when(data: (allContacts) {
            return Text(
              "${allContacts[0].length} Contact${allContacts[0].length == 1 ? '' : 's'}",
              style: const TextStyle(fontSize: 12),
            );
          }, error: (error, stackTrace) {
            return const SizedBox();
          }, loading: () {
            return const Text(
              "counting...",
              style: TextStyle(fontSize: 12),
            );
          }),
        ]),
        leading: const BackButton(),
        actions: [
          CustomIconButton(onTap: () {}, icon: Icons.search),
          CustomIconButton(onTap: () {}, icon: Icons.more_vert)
        ],
      ),
      body: ref.watch(contactControllerProvider).when(data: (allContacts) {
        return ListView.builder(
            itemCount: allContacts[1].length + allContacts[0].length,
            itemBuilder: (context, index) {
              late UserModel firebaseContacts;
              late UserModel phoneContacts;
              if (index < allContacts[0].length) {
                firebaseContacts = allContacts[0][index];
              } else {
                phoneContacts = allContacts[1][index - allContacts[0].length];
              }

              return index < allContacts[0].length
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (index == 0)
                          Column(
                            children: [
                              myListTile(
                                  leading: Icons.group, text: "New Group"),
                              myListTile(
                                  leading: Icons.contacts,
                                  text: "New Contact",
                                  trailing: Icons.qr_code),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: Text(
                                  'Contacts on WhatsApp',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: context.theme.greyColor),
                                ),
                              ),
                            ],
                          ),
                        ContactCard(
                          contactSource: firebaseContacts,
                          onTap: () => Navigator.of(context).pushNamed(
                              Routes.chat,
                              arguments: firebaseContacts),
                        )
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          if (index == allContacts[0].length)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: Text(
                                'Contacts on WhatsApp',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: context.theme.greyColor),
                              ),
                            ),
                          ContactCard(
                            contactSource: phoneContacts,
                            onTap: () => shareSmsLink(
                                phoneContacts.phoneNumber, context),
                          )
                        ]);
            });
      }, error: ((error, stackTrace) {
        return null;
      }), loading: () {
        return Center(
          child: CircularProgressIndicator(
              color: context.theme.authAppbarTextColor),
        );
      }),
    );
  }

  ListTile myListTile(
      {required IconData leading, required String text, IconData? trailing}) {
    return ListTile(
      contentPadding: const EdgeInsets.only(top: 10, left: 20, right: 10),
      leading: CircleAvatar(
        radius: 20,
        backgroundColor: AppColor.greenDark,
        child: Icon(
          leading,
          color: Colors.white,
        ),
      ),
      title: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
      trailing: Icon(
        trailing,
        color: AppColor.greyDark,
      ),
    );
  }
}
