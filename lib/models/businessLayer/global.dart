import 'package:flutter/widgets.dart';

bool isDarkModeEnable = false;
bool isRTL = false;
List<String> rtlLanguageCodeLList = ['ar', 'arc', 'ckb', 'dv', 'fa', 'ha', 'he', 'khw', 'ks', 'ps', 'ur', 'uz_AF', 'yi'];
String languageCode;

List<Color> gradientColors = [
  isDarkModeEnable ? Color(0xFF862254) : Color.fromARGB(255, 252, 22, 95),
  isDarkModeEnable ? Color(0xFF483585) : Color.fromARGB(255, 250, 82, 135),
];

List<Color> scaffoldBackgroundGradientColors = [
  Color(0xFF03000C),
  Color(0xFF292343),
];
