import 'package:flutter/material.dart';

/// Colores de toda la app. Cambia aquí y se actualiza en todas las pantallas.
class AppColors {
  AppColors._();

  static const Color primary = Color(0xFFFF7A59);
  static const Color primaryLight = Color(0xFFFFB38A);
  static const Color card = Color(0xFFF1F1F4);
  static const Color textDark = Color(0xFF2D2D2D);
  static const Color textGrey = Color(0xFF9E9E9E);
  static const Color toggleOff = Color(0xFFD6D6D6);

  static const LinearGradient mainGradient = LinearGradient(
    colors: [primaryLight, primary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
