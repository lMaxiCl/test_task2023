import 'package:flutter/material.dart';

class ThemeSetupUtil {
  static const Color _backgroundColor = Colors.white;
  static const Color _onBackgroundTextColor = Colors.black;
  static const Color _primaryColor = Colors.blue;

  static ThemeData setupTheme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: _primaryColor,
        brightness: Brightness.light,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: _primaryColor, minimumSize: const Size(250, 50)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey.withOpacity(0.20),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.red, width: 5.0),
        ),
      ),
      appBarTheme: const AppBarTheme(
          color: Colors.transparent,
          toolbarHeight: 100,
          elevation: 0,
          titleTextStyle: TextStyle(
              color: _onBackgroundTextColor,
              fontSize: 24,
              fontWeight: FontWeight.bold),
          centerTitle: true),
    );
  }
}
