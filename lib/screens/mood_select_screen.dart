import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/mood_button.dart';

class MoodSelectScreen extends StatelessWidget {
  const MoodSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
      title: Text(
  'harmonylink',
      style: GoogleFonts.pacifico(
        fontSize: 26,
        fontWeight: FontWeight.w500,
        color: theme.appBarTheme.foregroundColor ?? theme.colorScheme.onPrimary,
      ),
    ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface.withOpacity(0.95),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: theme.shadowColor.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Semantics(
                header: true,
                child: Text(
                  'choose your mood',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.3,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 28),
              Expanded(
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    alignment: WrapAlignment.center,
                    children: const [
                      MoodButton(
                          label: 'calm + collected',
                          mood: 'calm & collected',
                          icon: Icons.self_improvement),
                      MoodButton(
                          label: 'low energy',
                          mood: 'low energy',
                          icon: Icons.bedtime),
                      MoodButton(
                          label: 'uplifted',
                          mood: 'uplifted',
                          icon: Icons.sunny),
                      MoodButton(
                          label: 'romantic',
                          mood: 'romantic',
                          icon: Icons.favorite),
                      MoodButton(
                          label: 'heartbroken',
                          mood: 'heartbroken',
                          icon: Icons.heart_broken),
                      MoodButton(
                          label: 'nostalgic',
                          mood: 'nostalgic',
                          icon: Icons.history),
                      MoodButton(
                          label: 'party',
                          mood: 'party',
                          icon: Icons.celebration),
                      MoodButton(
                          label: 'focused',
                          mood: 'focused',
                          icon: Icons.track_changes),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}