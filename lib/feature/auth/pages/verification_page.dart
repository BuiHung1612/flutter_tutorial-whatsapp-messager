import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_messenger/common/extentions/custom_theme_extention.dart';
import 'package:whatsapp_messenger/common/widgets/custom_icon_button.dart';
import 'package:whatsapp_messenger/feature/auth/controller/auth_controller.dart';
import 'package:whatsapp_messenger/feature/auth/widgets/custom_text_field.dart';

class VerificationPage extends ConsumerWidget {
  final String verificationId;
  final String phoneNumber;
  const VerificationPage(
      {super.key, required this.verificationId, required this.phoneNumber});

  void verifyOtpCode(BuildContext context, WidgetRef ref, String otpCode) {
    ref.read(authControllerProvider).verifyOTPCode(
        context: context,
        verificationId: verificationId,
        otpCode: otpCode,
        mounted: true);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        actions: [CustomIconButton(onTap: () {}, icon: Icons.more_vert)],
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          "Xác minh số điện thoại",
          style: TextStyle(color: context.theme.authAppbarTextColor),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    style:
                        TextStyle(color: context.theme.greyColor, height: 1.5),
                    children: [
                      TextSpan(
                          text:
                              "You've tried to register +84$phoneNumber. Wait before requesting an SMS or call with your code. "),
                      TextSpan(
                          text: "Wrong number?",
                          style: TextStyle(color: context.theme.blueColor))
                    ])),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 80),
            child: CustomTextField(
              hintText: "- - -  - - -",
              fontSize: 30,
              autoFocus: true,
              maxLength: 6,
              keyboardType: TextInputType.number,
              onChanged: (text) {
                if (text.length == 6) {
                  verifyOtpCode(context, ref, text);
                }
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Enter 6-digit code",
            style: TextStyle(color: context.theme.greyColor),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Icon(
                Icons.message,
                color: context.theme.greyColor,
              ),
              const SizedBox(
                width: 30,
              ),
              Text(
                'Resend SMS',
                style: TextStyle(color: context.theme.greyColor),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Divider(
            color: context.theme.blueColor!.withOpacity(0.2),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Icon(
                Icons.call,
                color: context.theme.greyColor,
              ),
              const SizedBox(
                width: 30,
              ),
              Text(
                'Call Me',
                style: TextStyle(color: context.theme.greyColor),
              )
            ],
          ),
        ]),
      ),
    );
  }
}
