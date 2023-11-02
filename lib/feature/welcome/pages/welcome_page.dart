import 'package:flutter/material.dart';
import 'package:whatsapp_messenger/common/extentions/custom_theme_extention.dart';
import 'package:whatsapp_messenger/common/routes/routes.dart';
import 'package:whatsapp_messenger/common/widgets/custom_elevated_button.dart';
import 'package:whatsapp_messenger/feature/welcome/widgets/language_button.dart';
import 'package:whatsapp_messenger/feature/welcome/widgets/privacy_and_terms.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  navigateToLoginPage(context) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(Routes.login, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: Image.asset(
              'assets/images/circle.png',
              color: context.theme.circleImageColor,
            ),
          )),
          const Expanded(
            child: Column(
              children: [
                Text(
                  "Welcome to WhatsApp",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                PrivacyAndTerms(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 120, vertical: 20),
                  child: LanguageButton(),
                ),
              ],
            ),
          ),
          CustomElevatedButton(
            text: "AGREE AND CONTINUE",
            onPressed: () => navigateToLoginPage(context),
          )
        ],
      ),
    ));
  }
}
