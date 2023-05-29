import 'package:flutter/material.dart';
import 'package:flutter/src/material/material_state.dart';

class AppStyles {
  static const TextStyle headingStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle bodyStyle = TextStyle(
    fontSize: 16,
    color: Colors.grey,
  );

  static const Color accentColor = Colors.black; // Додайте цей рядок

  static ButtonStyle primaryButtonStyle = ButtonStyle( // Видаліть "const" перед ButtonStyle
    backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
    textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(color: accentColor)), // Використайте accentColor з AppStyles
  );
}
