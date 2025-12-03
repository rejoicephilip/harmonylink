import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'screens/mood_select_screen.dart';
import 'providers/theme_provider.dart';
import 'providers/playlist_provider.dart';
import 'firebase_options.dart';
import 'services/auth_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await AuthService().signInAnon();

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
            title: 'harmonylink',
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