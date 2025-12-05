import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  MaterialColor _themeColor = Colors.blue;

  MaterialColor get themeColor => _themeColor;

 ThemeData get currentTheme {
  final color = _themeColor;
  return ThemeData(
    useMaterial3: true, 
    colorScheme: ColorScheme.fromSeed(
      seedColor: color,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: color.shade500,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: color,
      foregroundColor: Colors.white,
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(fontSize: 14),
    ),
  );
}

Future<void> loadTheme() async {
  final prefs = await SharedPreferences.getInstance();
  final index = prefs.getInt('themeColorIndex') ?? 0;
  _themeColor = Colors.primaries[index];
  notifyListeners();
}
void setTheme(MaterialColor newColor) async {
  _themeColor = newColor;
  notifyListeners();
  
  final prefs = await SharedPreferences.getInstance();
  prefs.setInt('themeColorIndex', Colors.primaries.indexOf(newColor));
}
}