import 'package:flutter/material.dart';

/// LIGHT THEME
ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    primary: Colors.blueAccent,           // Buttons, highlights
    onPrimary: Colors.white,
    surface: Colors.white,
    onSurface: Colors.black87,
    secondary: Colors.cyan.shade100,
    tertiary: Colors.grey.shade100,
    inversePrimary: Colors.blue.shade900, // Headers
  ),
  scaffoldBackgroundColor: Colors.grey.shade50,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey.shade50,
    foregroundColor: Colors.blueAccent,
    elevation: 0,
    titleTextStyle: TextStyle(
      color: Colors.blueAccent,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.blueAccent,
    foregroundColor: Colors.white,
  ),
  cardTheme: CardThemeData(
    color: Colors.white,
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),
);

/// DARK THEME
ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.dark(
    primary: Colors.cyanAccent,
    onPrimary: Colors.black,
    surface: Colors.grey.shade900,
    onSurface: Colors.white70,
    secondary: Colors.cyan.shade700,
    tertiary: Colors.grey.shade800,
    inversePrimary: Colors.cyanAccent,
  ),
  scaffoldBackgroundColor: Colors.grey.shade900,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey.shade900,
    foregroundColor: Colors.cyanAccent,
    elevation: 0,
    titleTextStyle: TextStyle(
      color: Colors.cyanAccent,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.cyanAccent,
    foregroundColor: Colors.black,
  ),
  cardTheme: CardThemeData(
    color: Colors.grey.shade800,
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),
);


/// THEME PROVIDER (ChangeNotifier)
class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  ThemeMode get currentTheme => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
