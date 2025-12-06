import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/playlist.dart';
import '../providers/playlist_provider.dart';

class CreatePlaylistScreen extends StatefulWidget {
  const CreatePlaylistScreen({super.key});

  @override
  State<CreatePlaylistScreen> createState() => _CreatePlaylistScreenState();
}

class _CreatePlaylistScreenState extends State<CreatePlaylistScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _song1Controller = TextEditingController();
  final TextEditingController _song1Link = TextEditingController();
  final TextEditingController _song2Controller = TextEditingController();
  final TextEditingController _song2Link = TextEditingController();
  final TextEditingController _song3Controller = TextEditingController();
  final TextEditingController _song3Link = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  bool _isSaving = false;
  List<Map<String, String>> _addedSongs = [];

  @override
  void dispose() {
    _titleController.dispose();
    _song1Controller.dispose();
    _song2Controller.dispose();
    _song3Controller.dispose();
    _descriptionController.dispose();
    _song1Link.dispose();
    _song2Link.dispose();
    _song3Link.dispose();
    super.dispose();
  }

  Future<void> _savePlaylist(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    final String mood =
        (ModalRoute.of(context)?.settings.arguments as String?) ?? 'unknown mood';

    final List<Map<String, String>> songs = [];

    void addIfValid(String title, String link) {
      if (title.trim().isNotEmpty && link.trim().isNotEmpty) {
        final uri = Uri.tryParse(link.trim());
        if (uri != null && uri.isAbsolute) {
          songs.add({'title': title.trim(), 'link': link.trim()});
        }
      }
    }

    addIfValid(_song1Controller.text, _song1Link.text);
    addIfValid(_song2Controller.text, _song2Link.text);
    addIfValid(_song3Controller.text, _song3Link.text);
    _addedSongs.forEach((song) => addIfValid(song['title'] ?? '', song['link'] ?? ''));

    if (songs.length < 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('please provide at least 3 valid songs.')),
      );
      return;
    }

    setState(() {
      _isSaving = true;
    });

    final playlist = Playlist(
      id: '',
      mood: mood,
      title: _titleController.text.trim(),
      songs: songs,
      description: _descriptionController.text.trim().isEmpty
          ? null
          : _descriptionController.text.trim(),
      createdAt: DateTime.now(),
      userId: FirebaseAuth.instance.currentUser!.uid,
    );

    final playlistProvider = Provider.of<PlaylistProvider>(context, listen: false);
    await playlistProvider.addPlaylist(playlist);

    setState(() {
      _isSaving = false;
    });

    if (mounted) {
      Navigator.pushReplacementNamed(context, '/feed');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final labelStyle = theme.textTheme.bodyMedium?.copyWith(
      color: theme.colorScheme.onSurface,
    );

    final String mood =
        (ModalRoute.of(context)?.settings.arguments as String?) ?? 'unknown mood';

    return Scaffold(
      appBar: AppBar(
        title: Text('mood selected: $mood'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('playlist title', style: labelStyle),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _titleController,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(hintText: 'e.g. late night thoughts'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'please enter a title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                Text('song 1 (required)', style: labelStyle),
                TextFormField(
                  controller: _song1Controller,
                  decoration: const InputDecoration(hintText: 'song name'),
                  validator: (value) =>
                      value == null || value.trim().isEmpty ? 'required' : null,
                ),
                const SizedBox(height: 16),
                Text('song link', style: labelStyle),
                TextFormField(
                  controller: _song1Link,
                  decoration: const InputDecoration(hintText: 'paste song link'),
                  validator: (value) {
                    final uri = Uri.tryParse(value ?? '');
                    if (value == null || value.trim().isEmpty || uri == null || !uri.isAbsolute) {
                      return 'enter a valid URL';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Text('song 2', style: labelStyle),
                TextFormField(
                  controller: _song2Controller,
                  decoration: const InputDecoration(hintText: 'song name'),
                  validator: (value) =>
                      value == null || value.trim().isEmpty ? 'required' : null,
                ),
                const SizedBox(height: 16),
                Text('song link', style: labelStyle),
                TextFormField(
                  controller: _song2Link,
                  decoration: const InputDecoration(hintText: 'paste song link'),
                  validator: (value) {
                    final uri = Uri.tryParse(value ?? '');
                    if (value == null || value.trim().isEmpty || uri == null || !uri.isAbsolute) {
                      return 'enter a valid URL';
                    }
                    return null;
                },
                ),
                const SizedBox(height: 16),
                Text('song 3', style: labelStyle),
                TextFormField(
                  controller: _song3Controller,
                  decoration: const InputDecoration(hintText: 'song name'),
                  validator: (value) =>
                      value == null || value.trim().isEmpty ? 'required' : null,
                ),
                const SizedBox(height: 16),
                Text('song link', style: labelStyle),
                TextFormField(
                  controller: _song3Link,
                  decoration: const InputDecoration(hintText: 'paste song link'),
                  validator: (value) {
                    final uri = Uri.tryParse(value ?? '');
                    if (value == null || value.trim().isEmpty || uri == null || !uri.isAbsolute) {
                      return 'enter a valid URL';
                    }
                    return null;
                },
                ),
                const SizedBox(height: 16),
                Text('description', style: labelStyle),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 3,
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () async {
                    final newSongs = await Navigator.pushNamed(context, '/addSongs');
                    if (newSongs is List<Map<String, String>>) {
                      setState(() {
                        _addedSongs.addAll(newSongs);
                    });
                    }
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('add more songs'),
                ),
                if (_addedSongs.isNotEmpty) ...[
                  const SizedBox(height: 32),
                  Text('added songs:', style: theme.textTheme.bodyLarge),
                  const SizedBox(height: 12),
                  ..._addedSongs.map((song) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: ListTile(
                          title: Text(song['title'] ?? ''),
                          subtitle: Text(song['link'] ?? ''),
                      ),
                      )),
                ],
                const SizedBox(height: 36),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isSaving ? null : () => _savePlaylist(context),
                    child: _isSaving
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('create playlist'),
                  ),
               ),
              ],
            ),
        ),
        ),
    ),
    );
  }
}
