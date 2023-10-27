import 'package:flutter/material.dart';
import 'package:whatsapp_messenger/common/extentions/custom_theme_extention.dart';

showAlertDialog(
    {required BuildContext context, required String message, String? btnText}) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content:
              Text(message, style: TextStyle(color: context.theme.greyColor)),
          contentPadding: const EdgeInsetsDirectional.fromSTEB(20, 29, 20, 0),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  btnText ?? 'OK',
                  style: TextStyle(color: context.theme.circleImageColor),
                ))
          ],
        );
      });
}
