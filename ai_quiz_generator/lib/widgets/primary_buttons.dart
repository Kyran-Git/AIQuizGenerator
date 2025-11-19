import 'package:flutter/material.dart';
import 'package:ai_quiz_generator/theme/app_theme.dart';

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
    final buttonColor =
        color ?? (isOutlined ? AppTheme.lightWhite : AppTheme.primaryApp);
    final buttonTextColor =
        textColor ?? (isOutlined ? AppTheme.primaryApp : AppTheme.lightWhite);

    final effectivePadding = isDesktop
        ? EdgeInsets.all(20.0)
        : padding ?? EdgeInsets.all(14.0);
    final effectiveFontSize = isDesktop ? 20.0 : fontSize ?? 18.0;

    return MaterialButton(
      minWidth: isFullWidth ? double.infinity : null,
      padding: effectivePadding,
      onPressed: (isLoading || isDisabled) ? null : onPressed,
      disabledColor: color != null
          ? color!.withAlpha(150)
          : AppTheme.primaryApp.withAlpha(150),
      disabledTextColor: color ?? AppTheme.primaryApp,
      color: buttonColor,
      textColor: buttonTextColor,
      shape: isRounded
          ? StadiumBorder(
              side: isOutlined
                  ? const BorderSide(color: AppTheme.primaryApp, width: 2.0)
                  : BorderSide.none,
            )
          : RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              side: isOutlined
                  ? const BorderSide(color: AppTheme.primaryApp, width: 2.0)
                  : BorderSide.none,
            ),
      child: isLoading
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: buttonTextColor,
                      fontSize: effectiveFontSize,
                    ),
                  ),
                ),
                SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                    color: buttonTextColor,
                  ),
                ),
              ],
            )
          : Text(
              text,
              style: TextStyle(
                color: buttonTextColor,
                fontSize: effectiveFontSize,
              ),
            ),
    );
  }
}
