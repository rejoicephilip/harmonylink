import 'package:flutter_test/flutter_test.dart';
import 'package:harmonylink/providers/theme_provider.dart';


void main() {
  group('themeprovider', () {
    test('starts in light mode', (){
      final themeProvider = ThemeProvider();
      expect(themeProvider.isDark, isFalse);
    });

    test('toggleTheme switches to dark mode', (){
      final themeProvider = ThemeProvider();

      themeProvider.toggleTheme(true);
      expect(themeProvider.isDark, isTrue);
    });

    test('toggleTheme switches back to light mode', () {
      final themeProvider = ThemeProvider();

      themeProvider.toggleTheme(true);
      themeProvider.toggleTheme(false);
      expect(themeProvider.isDark, isFalse);
    });
  });
}