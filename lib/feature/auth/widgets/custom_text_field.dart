import 'package:flutter/material.dart';
import 'package:whatsapp_messenger/common/extentions/custom_theme_extention.dart';
import 'package:whatsapp_messenger/common/utils/colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final bool? readOnly;
  final TextAlign? textAlign;
  final TextInputType? keyboardType;
  final String? prefixText;
  final VoidCallback? onTap;
  final Widget? suffixIcon;
  final Function(String)? onChanged;
  final double? fontSize;
  final bool? autoFocus;
  final int? maxLength;

  const CustomTextField(
      {super.key,
      this.controller,
      this.hintText,
      this.readOnly,
      this.textAlign,
      this.keyboardType,
      this.prefixText,
      this.onTap,
      this.suffixIcon,
      this.onChanged,
      this.fontSize,
      this.autoFocus,
      this.maxLength});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      controller: controller,
      readOnly: readOnly ?? false,
      style: TextStyle(fontSize: fontSize),
      textAlign: textAlign ?? TextAlign.center,
      keyboardType: readOnly == null ? keyboardType : null,
      onChanged: onChanged,
      autofocus: autoFocus ?? false,
      maxLength: maxLength,
      decoration: InputDecoration(
          prefixText: prefixText,
          suffix: suffixIcon,
          hintStyle: TextStyle(color: context.theme.greyColor),
          counterText: "",
          hintText: hintText,
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColor.greenDark)),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColor.greenDark))),
    );
  }
}
