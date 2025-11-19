import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final Function() onPressed;
  final String text;
  final bool isFullWidth;
  final bool isRounded;
  final bool isOutlined;
  final bool isLoading;
  final EdgeInsets? padding;
  final bool isDisabled;
  final double? fontSize;
  final Color? color;
  final Color? textColor;
  final bool isDesktop;

  PrimaryButton({
    required this.onPressed,
    required this.text,
    this.isOutlined = false,
    this.isRounded = false,
    this.isFullWidth = false,
    this.isLoading = false,
    this.padding,
    this.isDisabled = false,
    this.fontSize,
    this.isDesktop = false,
    this.color,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
