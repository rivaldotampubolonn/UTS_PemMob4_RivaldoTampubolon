// utils/screen_utils.dart
import 'package:flutter/material.dart';

class ScreenUtils {
  static double width(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double height(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double widthPercentage(BuildContext context, double percentage) {
    return width(context) * (percentage / 100);
  }

  static double heightPercentage(BuildContext context, double percentage) {
    return height(context) * (percentage / 100);
  }

  static EdgeInsets safeAreaPadding(BuildContext context) {
    return MediaQuery.of(context).padding;
  }

  static double textScaleFactor(BuildContext context) {
    return MediaQuery.of(context).textScaleFactor;
  }

  static bool isKeyboardVisible(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom > 0;
  }

  static Orientation orientation(BuildContext context) {
    return MediaQuery.of(context).orientation;
  }

  static bool isPortrait(BuildContext context) {
    return orientation(context) == Orientation.portrait;
  }

  static bool isLandscape(BuildContext context) {
    return orientation(context) == Orientation.landscape;
  }

  static double aspectRatio(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return size.width / size.height;
  }

  static double scaledSize(BuildContext context, double size) {
    final width = ScreenUtils.width(context);
    return size * (width / 375);
  }

  static double scaledFontSize(BuildContext context, double fontSize) {
    final width = ScreenUtils.width(context);
    final scaleFactor = width / 375;
    return fontSize * scaleFactor.clamp(0.8, 1.5);
  }
}