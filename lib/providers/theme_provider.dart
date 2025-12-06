import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';


class ThemeProvider extends ChangeNotifier {
  MaterialColor _themeColor = Colors.blue;

  bool _isDarkMode = false;


  MaterialColor get themeColor => _themeColor;
  bool get isDarkMode => _isDarkMode;


 ThemeData get currentTheme {

  final color = _themeColor;
  
    final brightness = _isDarkMode ? Brightness.dark : Brightness.light;
    final isDark = brightness == Brightness.dark;


  return ThemeData(
    useMaterial3: true, 
    colorScheme: ColorScheme.fromSeed(
      seedColor: color,
      brightness: brightness,
    ),
    scaffoldBackgroundColor:  isDark ? Colors.grey[900] : Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: color.shade500,
      foregroundColor: Colors.white,
      elevation: 0,
        titleTextStyle: GoogleFonts.pacifico( 
        fontSize: 26,
        fontWeight: FontWeight.bold,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: color,
      foregroundColor: Colors.white,
    ),
   textTheme: GoogleFonts.latoTextTheme(
         ThemeData(brightness: brightness).textTheme,
        ).copyWith(
          titleLarge: GoogleFonts.pacifico(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: isDark ? null : Colors.white, 
          ),
          bodyLarge: GoogleFonts.lato(
            fontSize: 16,
            color: isDark ? Colors.white : Colors.black,
          ),
          bodyMedium: GoogleFonts.lato(
            fontSize: 14,
            color: isDark ? Colors.white70 : Colors.black87,
          ),
          bodySmall: GoogleFonts.lato(
            fontSize: 12,
            color: isDark ? Colors.white60 : Colors.black54,
          ),
        ),

    elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
    textStyle: const TextStyle(fontSize: 16),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),
),
    inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    contentPadding: const EdgeInsets.all(14),
  ),
    snackBarTheme: SnackBarThemeData(
    backgroundColor: color.shade500,
    contentTextStyle: const TextStyle(color: Colors.white),
  ),
    iconTheme: IconThemeData(color: color.shade700),
    dividerTheme: DividerThemeData(
    thickness: 1.2,
    color: color.shade300,
  ),
    listTileTheme: ListTileThemeData(
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    iconColor: color.shade600,
  ),
  pageTransitionsTheme: const PageTransitionsTheme(
  builders: {
    TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
  },
),
  visualDensity: VisualDensity.adaptivePlatformDensity, 
  hintColor: isDark ? Colors.white60 : Colors.black45,
  );
}

Future<void> loadTheme() async {
  final prefs = await SharedPreferences.getInstance();
  final index = prefs.getInt('themeColorIndex') ?? 0;
    final dark = prefs.getBool('isDarkMode') ?? false;

    _themeColor = Colors.primaries[index];
    _isDarkMode = dark;
  notifyListeners();
}
void setTheme(MaterialColor newColor) async {
  _themeColor = newColor;
  notifyListeners();
  
  final prefs = await SharedPreferences.getInstance();
  prefs.setInt('themeColorIndex', Colors.primaries.indexOf(newColor));
}
void toggleDarkMode(bool value) async {
    _isDarkMode = value;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', _isDarkMode);
  }
}