import 'package:flutter/material.dart';


class AppTheme {
  static final lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      shadowColor: Colors.white,

      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 20,
        color: Colors.blue.shade900,
        fontWeight: FontWeight.bold,
      ),
    ),


    scaffoldBackgroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.grey.shade700),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        iconColor: const WidgetStatePropertyAll<Color>(Colors.black),
        backgroundColor: WidgetStatePropertyAll<Color>(Colors.grey.shade200),
      ),
    ),
  );

  static final darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[900],
      shadowColor: Colors.black,
      centerTitle: true,
      titleTextStyle: const TextStyle(
        fontSize: 20,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: Colors.white),
      displayMedium: TextStyle(color: Colors.white),
      displaySmall: TextStyle(color: Colors.white),
      headlineMedium: TextStyle(color: Colors.white),
      headlineSmall: TextStyle(color: Colors.white),
      titleLarge: TextStyle(color: Colors.white),
      titleMedium: TextStyle(color: Colors.white70),
      titleSmall: TextStyle(color: Colors.white70),
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white70),
      bodySmall: TextStyle(color: Colors.white60),
      labelLarge: TextStyle(color: Colors.white),
      labelSmall: TextStyle(color: Colors.white54),
    ),
    scaffoldBackgroundColor: Colors.black,
    iconTheme: const IconThemeData(color: Colors.white),
    iconButtonTheme: const IconButtonThemeData(
      style: ButtonStyle(
        iconColor: WidgetStatePropertyAll<Color>(Colors.grey),
        backgroundColor: WidgetStatePropertyAll<Color>(Colors.black),
      ),
    ),
  );
}
