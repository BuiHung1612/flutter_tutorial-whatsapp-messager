import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_messenger/common/extentions/custom_theme_extention.dart';
import 'package:whatsapp_messenger/common/helper/show_alert_dialog.dart';
import 'package:whatsapp_messenger/common/models/user_modal.dart';
import 'package:whatsapp_messenger/common/utils/colors.dart';
import 'package:whatsapp_messenger/common/widgets/custom_icon_button.dart';
import 'package:whatsapp_messenger/feature/contact/controller/contacts_controller.dart';

String? encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map((e) =>
          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');
}

class ContactPage extends ConsumerWidget {
  const ContactPage({super.key});

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
                        ListTile(
                          contentPadding: const EdgeInsets.only(
                              left: 20, right: 10, top: 0, bottom: 0),
                          leading: CircleAvatar(
                              backgroundImage:
                                  firebaseContacts.avatarUrl.isNotEmpty
                                      ? NetworkImage(firebaseContacts.avatarUrl)
                                      : null,
                              backgroundColor:
                                  context.theme.greyColor!.withOpacity(0.3),
                              radius: 20,
                              child: firebaseContacts.avatarUrl.isEmpty
                                  ? const Icon(
                                      Icons.person,
                                      size: 30,
                                    )
                                  : null),
                          title: Text(
                            firebaseContacts.username,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: context.theme.greyColor),
                          ),
                          subtitle: Text(
                            "Hey there! I'm using WhatsApp",
                            style: TextStyle(
                                color: context.theme.greyColor,
                                fontWeight: FontWeight.w600),
                          ),
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
                          ListTile(
                            onTap: () async {
                              Uri sms = Uri.parse(
                                  "sms:${Platform.isAndroid ? phoneContacts.phoneNumber : phoneContacts.phoneNumber.replaceAll(' ', '-')}${Platform.isAndroid ? "?" : "&"}body=Let's chat on WhatsApp! it's a fast, simple, and secure app we can call each other for free. Get it at https://whatsappme.com/dl/");

                              await launchUrl(sms);
                            },
                            contentPadding: const EdgeInsets.only(
                                left: 20, right: 10, top: 0, bottom: 0),
                            leading: CircleAvatar(
                                backgroundImage:
                                    phoneContacts.avatarUrl.isNotEmpty
                                        ? NetworkImage(phoneContacts.avatarUrl)
                                        : null,
                                backgroundColor:
                                    context.theme.greyColor!.withOpacity(0.3),
                                radius: 20,
                                child: phoneContacts.avatarUrl.isEmpty
                                    ? const Icon(
                                        Icons.person,
                                        size: 30,
                                      )
                                    : null),
                            title: Text(
                              phoneContacts.username,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: context.theme.greyColor),
                            ),
                            subtitle: Text(
                              "Hey there! I'm using WhatsApp",
                              style: TextStyle(
                                  color: context.theme.greyColor,
                                  fontWeight: FontWeight.w600),
                            ),
                            trailing: TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                  foregroundColor: AppColor.greenDark),
                              child: const Text("INVATE"),
                            ),
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
}
