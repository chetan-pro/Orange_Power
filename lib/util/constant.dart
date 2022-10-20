import 'package:flutter/material.dart';

class Constants {
  static const double kPadding = 10.0;
  static const Color purpleLight = Color(0XFF1e224c);
  static const Color purpleDark = Color(0XFF0d193e);
  static const Color orange = Color(0XFFec8d2f);
  static const Color red = Color(0XFFf44336);
  static const Color white = Color(0XFFFFFFFF);
  static const Color lineColor = Color(0xff37434d);
  static const Color chartTextColor = Color(0xff68737d);
  static const Color chartTextLightColor = Color(0xff23b6e6);
  static const List<Color> lightGradientColors = [
    Color(0xff23b6e6),
    Color(0xff02d39a),
  ];
  static const List<Color> darkGradientColors = [
    Constants.purpleLight,
    Color.fromARGB(255, 16, 29, 70),
  ];

  static const String baseUrl =
      "https://api.octopus.energy/v1/products/AGILE-18-02-21/electricity-tariffs/E-1R-AGILE-18-02-21-A/standard-unit-rates?";
}
