import 'package:flutter/material.dart';

class ColorConstants {
  static Color lightScaffoldBackgroundColor = hexToColor('#F9F9F9');
  static Color darkScaffoldBackgroundColor = hexToColor('#1D273A');
  static Color secondaryAppColor = hexToColor('#22DDA6');
  static Color secondaryDarkAppColor = Colors.white;
  static Color tipColor = hexToColor('#B6B6B6');
  static Color Primary = Colors.blue;
  static Color Danger = Colors.red;
  static Color Warning = Colors.orange;
  static Color success = Colors.green;
  static Color lightBlueAccent = Colors.lightBlueAccent;
  static Color lightBlue = Colors.lightBlue;
  static Color brightGray = Colors.grey.shade100;
  static Color lightGray = Colors.grey.shade200;
  static Color grey = Colors.grey;
  static Color black = const Color(0xFF000000);
  static Color black12 = Colors.black12;
  static Color black45 = Colors.black45;
  static Color black87 = Colors.black87;
  static Color white = const Color(0xFFFFFFFF);
  static List<Color> gradient = [
    Colors.green,
    Colors.green.shade400,
  ];
}

Color hexToColor(String hex) {
  assert(RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hex),
      'hex color must be #rrggbb or #rrggbbaa');

  return Color(
    int.parse(hex.substring(1), radix: 16) +
        (hex.length == 7 ? 0xff000000 : 0x00000000),
  );
}
