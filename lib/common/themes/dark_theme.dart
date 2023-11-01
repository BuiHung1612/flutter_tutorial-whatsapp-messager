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
          backgroundColor: AppColor.greyBackground,
          iconTheme: IconThemeData(color: AppColor.greyDark),
          titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light)),
      tabBarTheme: const TabBarTheme(
          unselectedLabelColor: AppColor.greyDark,
          labelColor: AppColor.greenDark,
          indicator: UnderlineTabIndicator(
              borderSide: BorderSide(color: AppColor.greenDark, width: 2))),
      bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: AppColor.greyBackground,
          modalBackgroundColor: AppColor.greyBackground,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)))),
      dialogBackgroundColor: AppColor.greyBackground,
      dialogTheme: DialogTheme(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColor.greenDark, foregroundColor: Colors.white));
}
