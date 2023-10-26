import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:whatsapp_messenger/common/extentions/custom_theme_extention.dart';
import 'package:whatsapp_messenger/common/utils/colors.dart';

class LanguageButton extends StatelessWidget {
  const LanguageButton({
    super.key,
  });

  showBottomModal(context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                Container(
                  height: 4,
                  width: 30,
                  decoration: BoxDecoration(
                      color: context.theme.greyColor!.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(5)),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    IconButton(
                        iconSize: 22,
                        splashRadius: 22,
                        splashColor: Colors.transparent,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(minWidth: 40),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.close_outlined,
                          color: context.theme.greyColor,
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Ngôn ngữ của ứng dụng",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: context.theme.textColor),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Divider(
                  color: context.theme.greyColor!.withOpacity(0.3),
                  thickness: .5,
                ),
                RadioListTile(
                  value: false,
                  groupValue: true,
                  onChanged: (value) {},
                  activeColor: AppColor.greenDark,
                  title: Text(
                    "Tiếng việt",
                    style: TextStyle(color: context.theme.textColor),
                  ),
                  subtitle: Text(
                    "(Ngôn ngữ của thiết bị)",
                    style: TextStyle(color: context.theme.greyColor),
                  ),
                ),
                RadioListTile(
                  value: false,
                  groupValue: true,
                  onChanged: (value) {},
                  activeColor: AppColor.greenDark,
                  title: Text(
                    "Afrikaans",
                    style: TextStyle(color: context.theme.textColor),
                  ),
                  subtitle: Text(
                    "Tiếng Afrikaans",
                    style: TextStyle(color: context.theme.greyColor),
                  ),
                ),
                RadioListTile(
                  value: false,
                  groupValue: true,
                  onChanged: (value) {},
                  activeColor: AppColor.greenDark,
                  title: Text(
                    "Shqip",
                    style: TextStyle(color: context.theme.textColor),
                  ),
                  subtitle: Text(
                    "Tiếng Albania",
                    style: TextStyle(color: context.theme.greyColor),
                  ),
                ),
                RadioListTile(
                  value: false,
                  groupValue: true,
                  onChanged: (value) {},
                  activeColor: AppColor.greenDark,
                  title: Text(
                    "Català",
                    style: TextStyle(color: context.theme.textColor),
                  ),
                  subtitle: Text(
                    "Tiếng Catalan",
                    style: TextStyle(color: context.theme.greyColor),
                  ),
                ),
                RadioListTile(
                  value: false,
                  groupValue: true,
                  onChanged: (value) {},
                  activeColor: AppColor.greenDark,
                  title: Text(
                    "English",
                    style: TextStyle(color: context.theme.textColor),
                  ),
                  subtitle: Text(
                    "Tiếng Anh",
                    style: TextStyle(color: context.theme.greyColor),
                  ),
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(20),
      color: context.theme.langBtnBgColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        splashFactory: NoSplash.splashFactory,
        highlightColor: context.theme.langBtnHighlightColor,
        onTap: () => showBottomModal(context),
        child: const Padding(
          padding: EdgeInsets.all(4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.language,
                color: AppColor.greenDark,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                "Tiếng Việt",
                style: TextStyle(
                  color: AppColor.greenDark,
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Icon(
                Icons.keyboard_arrow_down,
                color: AppColor.greenDark,
              )
            ],
          ),
        ),
      ),
    );
  }
}