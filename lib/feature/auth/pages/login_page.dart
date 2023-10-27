import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_messenger/common/extentions/custom_theme_extention.dart';
import 'package:whatsapp_messenger/common/helper/show_alert_dialog.dart';
import 'package:whatsapp_messenger/common/utils/colors.dart';
import 'package:whatsapp_messenger/common/widgets/custom_elevated_button.dart';
import 'package:whatsapp_messenger/common/widgets/custom_icon_button.dart';
import 'package:whatsapp_messenger/feature/auth/widgets/custom_text_field.dart';

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

  showCountryCodePicker() {
    showCountryPicker(
        context: context,
        onSelect: (country) {
          countryCodeController.text = country.phoneCode;
          countryNameController.text = country.name;
        },
        showPhoneCode: true,
        favorite: ['VN'],
        countryListTheme: CountryListThemeData(
            bottomSheetHeight: 600,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            searchTextStyle: TextStyle(color: context.theme.greyColor),
            flagSize: 22,
            borderRadius: BorderRadius.circular(20),
            textStyle: TextStyle(color: context.theme.greyColor),
            inputDecoration: InputDecoration(
                labelStyle: TextStyle(color: context.theme.textColor),
                prefixIcon: const Icon(
                  Icons.language,
                  color: AppColor.greenDark,
                ),
                hintText: "Tìm quốc gia",
                hintStyle: TextStyle(color: context.theme.greyColor),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: context.theme.greyColor!.withOpacity(0.2)),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColor.greenDark),
                ))));
  }

  sendOtp() {
    final phone = phoneNumberController.text;
    final name = countryNameController.text;
    if (phone.isEmpty) {
      return showAlertDialog(
          context: context, message: "Vui lòng nhập số điện thoại của bạn.");
    } else if (phone.length < 9) {
      return showAlertDialog(
          context: context,
          message: "Bạn vừa nhập số điện thoại quá ngắn tại quốc gia: $name");
    }
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
          CustomIconButton(
            onTap: () {},
            icon: Icons.more_vert,
          )
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
              onTap: showCountryCodePicker,
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
                    onTap: showCountryCodePicker,
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
        onPressed: sendOtp,
        text: "Tiếp",
        buttonWidth: 90,
      ),
    );
  }
}
