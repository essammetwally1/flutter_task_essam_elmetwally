import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFFFF4144);
  static const Color lightred = Color(0xFFFFDBDB);

  static const Color darkgrey = Color(0xFF090F1F);
  static const Color green = Color(0xFF3A813F);
  static const Color grey = Colors.grey;

  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF090F1F);
  static const Color blue = Color(0xFF0079FE);

  static ThemeData dartTheme = ThemeData();
  static ThemeData lightTheme = ThemeData(
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
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: blue,
      unselectedItemColor: grey,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedIconTheme: const IconThemeData(size: 24),
      unselectedIconTheme: const IconThemeData(size: 24),
      unselectedLabelStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: darkgrey,
      ),
      selectedLabelStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: blue,
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.all(20),
      filled: true,
      hintStyle: TextStyle(
        fontSize: 16,
        color: grey,
        fontWeight: FontWeight.w400,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: grey),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: primary),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: primary),
      ),
    ),
    tabBarTheme: TabBarThemeData(
      tabAlignment: TabAlignment.start,
      dividerColor: Colors.transparent,
      indicatorColor: Colors.transparent,
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
