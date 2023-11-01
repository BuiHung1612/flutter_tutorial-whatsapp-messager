import 'package:flutter/material.dart';
import 'package:whatsapp_messenger/common/extentions/custom_theme_extention.dart';

class CustomIconButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final Color? iconColor;
  final double? iconSize;
  final double? minWidth;
  final Color? background;
  final BoxBorder? border;
  const CustomIconButton({
    super.key,
    required this.onTap,
    required this.icon,
    this.iconColor,
    this.iconSize,
    this.minWidth,
    this.background,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: background, shape: BoxShape.circle, border: border),
      child: IconButton(
          splashColor: Colors.transparent,
          splashRadius: (minWidth ?? 45) - 25,
          padding: EdgeInsets.zero,
          iconSize: iconSize,
          onPressed: onTap,
          constraints: BoxConstraints(
              minWidth: minWidth ?? 45, minHeight: minWidth ?? 45),
          icon: Icon(
            icon,
            color: iconColor ?? Theme.of(context).appBarTheme.iconTheme!.color,
          )),
    );
  }
}
