import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  MaterialColor _themeColor = Colors.blue;

  MaterialColor get themeColor => _themeColor;

  ThemeData get currentTheme => ThemeData(
    primarySwatch: _themeColor,
  );

void setTheme(MaterialColor newColor) {
  _themeColor = newColor;
  notifyListeners();
}
}