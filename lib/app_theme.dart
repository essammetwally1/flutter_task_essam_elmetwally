import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFFFF4144);
  static const Color lightred = Color(0xFFFFDBDB);

  static const Color grey = Color(0xFF090F1F);

  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF090F1F);
  static const Color blue = Color(0xFF0079FE);

  static ThemeData lightTheme = ThemeData();
  static ThemeData dartTheme = ThemeData(
    scaffoldBackgroundColor: white,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    splashFactory: NoSplash.splashFactory,

    appBarTheme: AppBarTheme(
      backgroundColor: white,
      foregroundColor: primary,
      centerTitle: true,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(color: primary),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0,
      enableFeedback: false,
      backgroundColor: grey,
      type: BottomNavigationBarType.fixed,
    ),

    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.all(20),
      filled: true,
      fillColor: grey,
      hintStyle: TextStyle(
        fontSize: 16,
        color: grey,
        fontWeight: FontWeight.w400,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: grey),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: primary),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: primary),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      ),
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: black,
      ),

      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: white,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: white,
      ),
      displaySmall: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w400,
        color: grey,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        overlayColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        foregroundColor: blue,
        textStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          decoration: TextDecoration.none,
        ),
      ),
    ),
  );
}
