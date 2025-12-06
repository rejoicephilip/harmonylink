import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';


class ThemeSelectorScreen extends StatelessWidget{
   const ThemeSelectorScreen({super.key});

  @override
  Widget build(BuildContext context) {

     final themeProvider = Provider.of<ThemeProvider>(context);

    final List<MaterialColor> themeColors =  [
    Colors.blue,
    Colors.pink,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.yellow,
    Colors.teal,
    Colors.red,
  ];

    return Scaffold(
      appBar: AppBar(
        title: Text('pick your theme!',
          style: Theme.of(context).textTheme.titleLarge,
      ),
      
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              padding:  EdgeInsets.all(16),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: themeColors.map((color) {
                return GestureDetector(
                  onTap: () {
                    themeProvider.setTheme(color);
                    ScaffoldMessenger.of(context).showSnackBar(
                       SnackBar(
                        content: Text('theme updated'),
                        duration: Duration(milliseconds: 800),
                      ),
                    );
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                        width: 1.5,
                      ),
                    ),
                    child:  SizedBox.expand(),
                  ),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'dark mode',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Switch(
                  value: themeProvider.isDarkMode,
                  onChanged: (value) {
                    themeProvider.toggleDarkMode(value);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}