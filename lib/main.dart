import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/mood_select_screen.dart';
import 'providers/theme_provider.dart';
import 'providers/playlist_provider.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const HarmonyLinkApp());
}

class HarmonyLinkApp extends StatelessWidget {
  const HarmonyLinkApp({super.key});

  @override
  Widget build(BuildContext) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => PlaylistProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'HarmonyLink',
            theme: themeProvider.currentTheme,
            initialRoute: '/moodSelect',
            routes: {
              '/moodSelect': (context) => const MoodSelectScreen(),
              // FINISH AFTER
              // '/createPlaylist':
              // '/feed':
              // '/playlistDetail':
              // '/themeSelector':
             },
          );
        },
      ),
    );
  }
}