import 'package:flutter/material.dart';

class MoodSelectScreen extends StatelessWidget {
  const MoodSelectScreen({super.key});

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
              onPressed: () {
                // UPDATE LATER
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('mood selected (//////CHANGE ME LATER)')),
                );
              },
              child: const Text('calm + collected'),
            ),
          ],
        ),
        ),
     );
  }
}