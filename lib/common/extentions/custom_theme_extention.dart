import 'package:flutter/material.dart';
import 'package:whatsapp_messenger/common/utils/colors.dart';

extension ExtendedTheme on BuildContext {
  CustomThemeExtention get theme {
    return Theme.of(this).extension<CustomThemeExtention>()!;
  }
}

class CustomThemeExtention extends ThemeExtension<CustomThemeExtention> {
  static const lightMode = CustomThemeExtention(
      circleImageColor: Color(0xFF25D366),
      greyColor: AppColor.greyLight,
      blueColor: AppColor.blueLight,
      langBtnBgColor: Color(0xFFF7F8FA),
      langBtnHighlightColor: Color(0xFFE8E8ED),
      textColor: Colors.black,
      authAppbarTextColor: AppColor.greenLight);

  static const darkMode = CustomThemeExtention(
      circleImageColor: AppColor.greenDark,
      greyColor: AppColor.greyDark,
      blueColor: AppColor.blueDark,
      langBtnBgColor: Color(0xFF182229),
      langBtnHighlightColor: Color(0xFF09141A),
      textColor: Colors.white,
      authAppbarTextColor: Color(0xFFE9EDEF));

  final Color? circleImageColor;
  final Color? greyColor;
  final Color? blueColor;
  final Color? langBtnBgColor;
  final Color? langBtnHighlightColor;
  final Color? textColor;
  final Color? authAppbarTextColor;

  const CustomThemeExtention(
      {this.circleImageColor,
      this.greyColor,
      this.blueColor,
      this.langBtnBgColor,
      this.langBtnHighlightColor,
      this.textColor,
      this.authAppbarTextColor});

  @override
  ThemeExtension<CustomThemeExtention> copyWith({
    Color? circleImageColor,
    Color? greyColor,
    Color? blueColor,
    Color? langBtnBgColor,
    Color? langBtnHighlightColor,
    Color? textColor,
    Color? authAppbarTextColor,
  }) {
    return CustomThemeExtention(
      circleImageColor: circleImageColor ?? this.circleImageColor,
      greyColor: greyColor ?? this.greyColor,
      blueColor: blueColor ?? this.blueColor,
      langBtnBgColor: langBtnBgColor ?? this.langBtnBgColor,
      langBtnHighlightColor:
          langBtnHighlightColor ?? this.langBtnHighlightColor,
      textColor: textColor ?? this.textColor,
      authAppbarTextColor: authAppbarTextColor ?? this.authAppbarTextColor,
    );
  }

  @override
  ThemeExtension<CustomThemeExtention> lerp(
      covariant ThemeExtension<CustomThemeExtention>? other, double t) {
    if (other is! CustomThemeExtention) return this;
    return CustomThemeExtention(
      circleImageColor: Color.lerp(circleImageColor, other.circleImageColor, t),
      greyColor: Color.lerp(greyColor, other.greyColor, t),
      blueColor: Color.lerp(blueColor, other.blueColor, t),
      langBtnBgColor: Color.lerp(langBtnBgColor, other.langBtnBgColor, t),
      langBtnHighlightColor:
          Color.lerp(langBtnHighlightColor, other.langBtnHighlightColor, t),
      textColor: Color.lerp(textColor, other.textColor, t),
      authAppbarTextColor:
          Color.lerp(authAppbarTextColor, other.authAppbarTextColor, t),
    );
  }
}
