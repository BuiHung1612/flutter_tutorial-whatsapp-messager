import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:whatsapp_messenger/common/extentions/custom_theme_extention.dart';
import 'package:whatsapp_messenger/common/utils/colors.dart';

showLoadingDialog({
  required BuildContext context,
  required String message,
}) async {
  return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(mainAxisSize: MainAxisSize.min, children: [
            Row(
              children: [
                const CircularProgressIndicator(
                  color: AppColor.greenDark,
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: Text(
                  message,
                  style: TextStyle(
                      color: context.theme.greyColor,
                      height: 1.5,
                      fontSize: 15),
                ))
              ],
            )
          ]),
        );
      });
}
