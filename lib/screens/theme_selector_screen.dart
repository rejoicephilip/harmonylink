import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';


class ThemeSelectorScreen extends StatelessWidget{
  const ThemeSelectorScreen({super.key});

  final List<MaterialColor> themeColors = const [
    Colors.blue,
    Colors.pink,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.yellow,
    Colors.teal,
    Colors.red,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('pick you theme!')
      ),
      body: GridView.count(
        crossAxisCount: 3,
        padding: const EdgeInsets.all(16),
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        children: themeColors.map((color){
          return GestureDetector(
            onTap: () {
              final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
              themeProvider.setTheme(color);
              Navigator.pop(context);
            },
            child: Container(
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                   ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
