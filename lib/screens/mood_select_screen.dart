import 'package:flutter/material.dart';

class MoodSelectScreen extends StatelessWidget {
  const MoodSelectScreen({super.key});

  void _goToCreate(BuildContext context, String mood) {
    Navigator.pushNamed(
      context,
      '/createPlaylist',
      arguments: mood,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('select your mood'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'choose your mood',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _goToCreate(context, 'calm + collected'),
              child: const Text ('calm + collected'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _goToCreate(context, 'uplifted'), 
              child: const Text('uplifted'),
            ),
            // ADD THE REST
          ],
        ),
        ),
     );
  }
}