import 'package:flutter/material.dart';
import 'package:whatsapp_messenger/common/extentions/custom_theme_extention.dart';
import 'package:whatsapp_messenger/common/utils/colors.dart';

class PrivacyAndTerms extends StatelessWidget {
  const PrivacyAndTerms({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: "Read our ",
              style: TextStyle(height: 1.5, color: context.theme.greyColor),
              children: [
                TextSpan(
                    text: "Privacy Policy ",
                    style: TextStyle(color: context.theme.blueColor)),
                const TextSpan(
                    text: ' Tap "Agree and continue" to accept the '),
                TextSpan(
                    text: "Terms of Services.",
                    style: TextStyle(color: context.theme.blueColor))
              ])),
    );
  }
}
