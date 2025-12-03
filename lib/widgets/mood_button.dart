import 'package:flutter/material.dart';

class MoodButton extends StatelessWidget{
  final String label;
  final String mood;

  const MoodButton({
    super.key,
    required this.label,
    required this.mood,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pop(context, mood);
      },
       child: Text(label),
       );
  }
}