// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

abstract class AppColors {
  static const Map<int, Color> _color = {
    50: Color.fromARGB(255, 142, 170, 255),
    100: Color.fromARGB(255, 142, 170, 255),
    200: Color.fromARGB(255, 142, 170, 255),
    300: Color.fromARGB(255, 142, 170, 255),
    400: Color.fromARGB(255, 142, 170, 255),
    500: Color.fromARGB(255, 142, 170, 255),
    600: Color.fromARGB(255, 142, 170, 255),
    700: Color.fromARGB(255, 142, 170, 255),
    800: Color.fromARGB(255, 142, 170, 255),
    900: Color.fromARGB(255, 142, 170, 255),
  };

  static const primarySwatch = MaterialColor(0xFF8EAAFB, _color);
  static const inactiveColor = Color(0xFFB7C9FD);
  static const textColor = Color(0xFF594C74);
  static const shadowColor = Color.fromRGBO(38, 0, 122, 0.15);
}
