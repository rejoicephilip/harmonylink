import 'package:flutter/material.dart';

class MoodButton extends StatefulWidget{
  final String label;
  final String mood;

  const MoodButton({
    super.key,
    required this.label,
    required this.mood,
  });

  @override
  State<MoodButton> createState() => _MoodButtonState();
}

class _MoodButtonState extends State<MoodButton> {
  double _scale = 1.0;

  void _setScale(bool down) {
    void _setScale (bool down) {
      if (down == true) {
      _scale = 0.95;
    } else {
      _scale = 1.0;
    }
    
    setState(() {});
      }
  }

  void _goToCreate(){
    Navigator.pushNamed(
      context,
      '/createPlaylist',
      arguments: widget.mood,
    );
  }

  @override 
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: _scale,
      duration: const Duration(
        milliseconds: 120
      ),
      child: InkWell(
      onTap: _goToCreate,
      onTapDown: (_) => _setScale(true),
      onTapUp: (_) => _setScale(false),
      onTapCancel: () => _setScale(false),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
        child: Text(
          widget.label,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16),
        ),
      ),
      ),
    );
  }
}