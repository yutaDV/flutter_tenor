import 'package:flutter/material.dart';

class AppColors {
  final Color primaryColor;
  final Color secondaryColor;
  final Color accentColor;

  const AppColors({
    required this.primaryColor,
    required this.secondaryColor,
    required this.accentColor,
  });

  static const AppColors defaultColors = AppColors(
    primaryColor: Color(0xFF000000),
    secondaryColor: Color(0xFFFFFFFF),
    accentColor: Color(0xFF00FF00),
  );
}

AppColors MyColors = AppColors(
  primaryColor: Colors.black,
  secondaryColor: Colors.white,
  accentColor: Colors.green,
);

AppColors StatusColors = AppColors(
  primaryColor: Colors.red,
  secondaryColor: Colors.yellow,
  accentColor: Colors.green,
);
