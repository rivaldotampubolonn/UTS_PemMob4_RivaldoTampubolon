import 'package:flutter/material.dart';

enum DeviceType { mobile, tablet, desktop }

class ResponsiveHelper {
  static DeviceType getDeviceType(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 600) return DeviceType.mobile;
    if (width < 900) return DeviceType.tablet;
    return DeviceType.desktop;
  }

  static EdgeInsets getResponsivePadding(BuildContext context) {
    final type = getDeviceType(context);
    return EdgeInsets.all(type == DeviceType.mobile ? 16 : (type == DeviceType.tablet ? 24 : 32));
  }

  static double getMaxContentWidth(BuildContext context) {
    final type = getDeviceType(context);
    if (type == DeviceType.mobile) return double.infinity;
    if (type == DeviceType.tablet) return 700;
    return 900;
  }
}

class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext, DeviceType) builder;
  const ResponsiveBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return builder(context, ResponsiveHelper.getDeviceType(context));
  }
}
