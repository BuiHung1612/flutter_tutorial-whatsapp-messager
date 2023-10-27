import 'package:flutter/material.dart';
import 'package:whatsapp_messenger/common/extentions/custom_theme_extention.dart';

class CustomIconButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final Color? iconColor;
  final double? iconSize;
  final double? minWidth;
  const CustomIconButton({
    super.key,
    required this.onTap,
    required this.icon,
    this.iconColor,
    this.iconSize,
    this.minWidth,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
        splashColor: Colors.transparent,
        splashRadius: 22,
        padding: EdgeInsets.zero,
        iconSize: iconSize,
        onPressed: onTap,
        constraints: BoxConstraints(minWidth: minWidth ?? 40),
        icon: Icon(
          icon,
          color: iconColor ?? context.theme.greyColor,
        ));
  }
}
