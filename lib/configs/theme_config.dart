import 'package:flutter/material.dart';

class ThemeConfig {
  static const Color primaryColor = Color.fromRGBO(156, 138, 88, 1);
  static const Color backgroundColor = Color.fromRGBO(255, 255, 255, 1);
  static const Color textColor = Color.fromRGBO(26, 18, 67, 1);
  static const Color primaryAccentColor = Color.fromRGBO(187, 167, 112, 1);

  static final themeData = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    fontFamily: 'Roboto',
    textTheme: const TextTheme(
      displayLarge:
          TextStyle(fontSize: 64.0, height: 1.5, fontWeight: FontWeight.w500),
      displayMedium:
          TextStyle(fontSize: 52.0, height: 1.5, fontWeight: FontWeight.w500),
      displaySmall:
          TextStyle(fontSize: 48.0, height: 1.5, fontWeight: FontWeight.w500),
      headlineMedium:
          TextStyle(fontSize: 32.0, height: 1.5, fontWeight: FontWeight.w500),
      headlineSmall:
          TextStyle(fontSize: 28.0, height: 1.5, fontWeight: FontWeight.w500),
      titleLarge:
          TextStyle(fontSize: 22.0, height: 1.5, fontWeight: FontWeight.w500),
      titleMedium:
          TextStyle(fontSize: 18.0, height: 1.5, color: Colors.black54),
      titleSmall:
          TextStyle(fontSize: 12.0, height: 1.5, color: Colors.black54),
      labelLarge:
          TextStyle(fontSize: 16.0, height: 1.5, color: Colors.black54),
      bodyLarge: TextStyle(fontSize: 16.0, height: 1.5),
      bodyMedium: TextStyle(fontSize: 16.0, height: 1.5),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: primaryColor,
      selectionColor: primaryColor.withOpacity(.5),
      selectionHandleColor: primaryColor
    ),
    inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      isCollapsed: true,
      contentPadding: const EdgeInsets.all(10),
      filled: true,
      fillColor: Colors.black.withOpacity(.08),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.black.withOpacity(.08))
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.black.withOpacity(.2))
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.black.withOpacity(.1))
      ),
      hintStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Colors.black38
      )
    ),

    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          )
        )
      )
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          )
        )
      )
    ),
  );
}