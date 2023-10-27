import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whatsapp_messenger/common/extentions/custom_theme_extention.dart';
import 'package:whatsapp_messenger/common/utils/colors.dart';

ThemeData lightTheme() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
      backgroundColor: AppColor.backgroundLight,
      scaffoldBackgroundColor: AppColor.backgroundLight,
      extensions: [CustomThemeExtention.lightMode],
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
              backgroundColor: AppColor.greenLight,
              foregroundColor: AppColor.backgroundLight,
              splashFactory: NoSplash.splashFactory,
              elevation: 0,
              shadowColor: Colors.transparent)),
      unselectedWidgetColor: AppColor.greyLight,
      appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(fontSize: 18),
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark)),
      bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: AppColor.backgroundLight,
          modalBackgroundColor: AppColor.backgroundLight,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)))),
      dialogBackgroundColor: AppColor.backgroundLight,
      dialogTheme: DialogTheme(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))));
}
