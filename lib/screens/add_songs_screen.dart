import 'package:flutter/material.dart';

class AddSongsScreen extends StatefulWidget{
  const AddSongsScreen({super.key});

  @override
  State<AddSongsScreen> createState() => _AddSongsScreenState();
}

class _AddSongsScreenState extends State<AddSongsScreen> {
    final TextEditingController _titleController = TextEditingController();
    final TextEditingController _linkController = TextEditingController();
 
   final List<Map<String, String>> _songs = [];

    void _addSong() {
    final title = _titleController.text.trim();
    final link = _linkController.text.trim();

    if (title.isEmpty || link.isEmpty) return;

    setState(() {
      _songs.add({'title': title, 'link': link});
    });

    _titleController.clear();
    _linkController.clear();
  }
  
  void _removeSong(int index) {
    setState(() {
      _songs.removeAt(index);
    });
  }
  
  @override
  void dispose() {
    _titleController.dispose();
    _linkController.dispose();
    super.dispose();
  }


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
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'song name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _linkController,
              decoration: const InputDecoration(
                labelText: 'song link',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: _addSong,
              child: const Text('add song'),
              ),
              const SizedBox(height: 16),

              Expanded(
                child: ListView.builder(
                  itemCount: _songs.length,
                  itemBuilder: (context, index){
                    final song = _songs[index];
                    return ListTile(
                       title: Text(song['title'] ?? ''),
                    subtitle: Text(song['link'] ?? ''),
                    );
                  },
                ),
          ),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, _songs);
              },
              child: const Text('back'),
            )
          ],
        ),
      ),
    );
  }
}