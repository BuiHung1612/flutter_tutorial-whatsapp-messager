import 'package:flutter/material.dart';
import 'package:whatsapp_messenger/common/extentions/custom_theme_extention.dart';
import 'package:whatsapp_messenger/common/utils/colors.dart';
import 'package:whatsapp_messenger/common/widgets/custom_elevated_button.dart';
import 'package:whatsapp_messenger/feature/auth/pages/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController countryNameController;
  late TextEditingController countryCodeController;
  late TextEditingController phoneNumberController;

  @override
  void initState() {
    countryNameController = TextEditingController(text: "Việt Nam");
    countryCodeController = TextEditingController(text: "84");
    phoneNumberController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    countryCodeController.dispose();
    countryCodeController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          "Nhập số điện thoại của bạn",
          style: TextStyle(color: context.theme.authAppbarTextColor),
        ),
        actions: [
          IconButton(
              splashColor: Colors.transparent,
              splashRadius: 22,
              padding: EdgeInsets.zero,
              iconSize: 22,
              onPressed: () {},
              constraints: const BoxConstraints(minWidth: 40),
              icon: Icon(
                Icons.more_vert,
                color: context.theme.greyColor,
              ))
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: "WhatsApp sẽ cần xác minh tài khoản của bạn. ",
                    style:
                        TextStyle(color: context.theme.greyColor, height: 1.5),
                    children: [
                      TextSpan(
                        text: "Số điện thoại của tôi là gì?",
                        style: TextStyle(
                            color: context.theme.blueColor, height: 1.5),
                      )
                    ])),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: CustomTextField(
              controller: countryNameController,
              onTap: () {},
              readOnly: true,
              suffixIcon: const Icon(
                (Icons.arrow_drop_down),
                color: AppColor.greenDark,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Row(
              children: [
                SizedBox(
                  width: 60,
                  child: CustomTextField(
                    controller: countryCodeController,
                    prefixText: "+",
                    onTap: () {},
                    readOnly: true,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: CustomTextField(
                  controller: phoneNumberController,
                  hintText: "Số điện thoại",
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.left,
                ))
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Nhà mạng có thể mất phí",
            style: TextStyle(color: context.theme.greyColor),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomElevatedButton(
        onPressed: () {},
        text: "Tiếp",
        buttonWidth: 90,
      ),
    );
  }
}
