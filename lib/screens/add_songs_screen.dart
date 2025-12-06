import 'package:flutter/material.dart';

class AddSongsScreen extends StatefulWidget {
  const AddSongsScreen({super.key});

  @override
  State<AddSongsScreen> createState() => _AddSongsScreenState();
}

class _AddSongsScreenState extends State<AddSongsScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();
  final List<Map<String, String>> _songs = [];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _addSong() {
    if (!_formKey.currentState!.validate()) return;

    final title = _titleController.text.trim();
    final link = _linkController.text.trim();

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

  bool _isValidUrl(String input) {
    return Uri.tryParse(input)?.hasAbsolutePath ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final labelStyle = theme.textTheme.bodyMedium?.copyWith(
      color: theme.colorScheme.onSurface,
    );

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        title: Text(
          'add your songs',
          style: theme.textTheme.titleLarge?.copyWith(color: theme.colorScheme.onPrimary),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'song name',
                  labelStyle: labelStyle,
                  border: const OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.trim().isEmpty ? 'song name is required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _linkController,
                decoration: InputDecoration(
                  labelText: 'song link',
                  labelStyle: labelStyle,
                  border: const OutlineInputBorder(),
                ),
                keyboardType: TextInputType.url,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) return 'link is required';
                  if (!_isValidUrl(value.trim())) return 'enter a valid URL';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _addSong,
                icon: const Icon(Icons.add),
                label: const Text('add song'),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: _songs.isEmpty
                    ? Center(
                        child: Text(
                          'no songs added yet',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.textTheme.bodyMedium?.color?.withOpacity(0.6),
                          ),
                        ),
                      )
                    : ListView.separated(
                        itemCount: _songs.length,
                        separatorBuilder: (_, __) => const Divider(),
                        itemBuilder: (context, index) {
                          final song = _songs[index];
                          return ListTile(
                            leading: const Icon(Icons.music_note),
                            title: Text(song['title'] ?? ''),
                            subtitle: Text(song['link'] ?? ''),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => _removeSong(index),
                              tooltip: 'remove',
                            ),
                          );
                        },
                      ),
              ),
          const SizedBox(height: 12),
ElevatedButton.icon(
  onPressed: () {
    if (_songs.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('please add at least one song')),
      );
      return;
    }
    Navigator.pop(context, _songs);
          },
          icon: const Icon(Icons.playlist_add_check),
          label: const Text('add song(s) to playlist'),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(48),
          ),
        ),
        const SizedBox(height: 12),
        ElevatedButton.icon(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
          label: const Text('back to playlist'),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(48),
            backgroundColor: theme.colorScheme.secondaryContainer,
            foregroundColor: theme.colorScheme.onSecondaryContainer,
          ),
        ),

            ],
          ),
        ),
      ),
    );
  }
}
