import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whatsapp_messenger/common/extentions/custom_theme_extention.dart';
import 'package:whatsapp_messenger/common/utils/colors.dart';

ThemeData darkTheme() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
      backgroundColor: AppColor.backgroundDark,
      scaffoldBackgroundColor: AppColor.backgroundDark,
      extensions: [CustomThemeExtention.darkMode],
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
              backgroundColor: AppColor.greenDark,
              foregroundColor: AppColor.backgroundDark,
              splashFactory: NoSplash.splashFactory,
              elevation: 0,
              shadowColor: Colors.transparent)),
      unselectedWidgetColor: AppColor.greyDark,
      appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light)),
      bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: AppColor.greyBackground,
          modalBackgroundColor: AppColor.greyBackground,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)))));
}
