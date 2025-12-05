import 'package:flutter/material.dart';

class AddSongsScreen extends StatefulWidget{
  const AddSongsScreen({super.key});

  @override
  State<AddSongsScreen> createState() => _AddSongsScreenState();
}

class _AddSongsScreenState extends State<AddSongsScreen> {
  final TextEditingController _songController = TextEditingController();
  final List<String> _songs = [];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('add your songs here'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _songController,
              decoration: const InputDecoration(
                labelText: 'song name',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: () {
                if (_songController.text.trim().isEmpty){
                return;
                }

                setState(() {
                  _songs.add(_songController.text.trim());
                });
                _songController.clear();
              }, 
              child: const Text('add song'),
              ),
              const SizedBox(height: 16),

              Expanded(
                child: ListView.builder(
                  itemCount: _songs.length,
                  itemBuilder: (context, index){
                    return ListTile(
                      title: Text(_songs[index]),
                    );
                  },
                ),
          ),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, _songs);
              },
              child: const Text('song added!'),
            )
          ],
        ),
      ),
    );
  }
}