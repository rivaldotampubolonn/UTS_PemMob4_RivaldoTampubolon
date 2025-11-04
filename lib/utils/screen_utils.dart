import 'package:flutter/material.dart';

class ScreenUtils {
  static double width(BuildContext context) => MediaQuery.of(context).size.width;
  static double height(BuildContext context) => MediaQuery.of(context).size.height;

  static double scaledSize(BuildContext context, double size) {
    final width = ScreenUtils.width(context);
    return size * (width / 375).clamp(0.8, 1.5);
  }

  static double scaledFontSize(BuildContext context, double fontSize) {
    return scaledSize(context, fontSize);
  }
}