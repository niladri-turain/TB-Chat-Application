import 'package:flutter/material.dart';

class AppColors {
  static const Color pink = Color(0xFFE5007D);
  static const Color indigo = Color(0xFF3A1FC9);
  static const Color ink = Color(0xFF1A1240);
  static const Color muted = Color(0xFF5E5A7A);
  static const Color background = Color(0xFFF6F4FD);
  static const Color line = Color(0xFFE7E3F5);
  static const Color online = Color(0xFF12A150);
  static const Color error = Color(0xFFC8102E);
  static const Color white = Color(0xFFFFFFFF);

  static const LinearGradient brandGradient = LinearGradient(
    colors: [pink, indigo],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient splashGradient = LinearGradient(
    colors: [pink, Color(0xFF8B2FD4), indigo],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
