import 'package:flutter/material.dart';

import '../widgets/mood_button.dart';

class MoodSelectScreen extends StatelessWidget {
  const MoodSelectScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('select your mood'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const[
            Text(
              'choose your mood',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),

            MoodButton(
              label: 'calm + collected',
              mood: 'calm + collected',
            ),
            SizedBox(height: 16),
            MoodButton(
              label: 'uplifted',
              mood: 'uplifted',
            ),
            // ADD THE REST
          ],
        ),
        ),
     );
  }
}
