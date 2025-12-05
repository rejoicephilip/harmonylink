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
  final TextEditingController _song2Controller = TextEditingController();
  final TextEditingController _song3Controller = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  bool _isSaving = false;

  @override 
  void dispose() {
    _titleController.dispose();
    _song1Controller.dispose();
    _song2Controller.dispose();
    _song3Controller.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
   Future<void> _savePlaylist(BuildContext context) async {
    if (_song1Controller.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('please enter at least three song links.')),
      );
      return;
    }

    setState(() {
      _isSaving = true;
    });

    final String mood =
        (ModalRoute.of(context)?.settings.arguments as String?) ??
            'unknown mood';

    final List<String> songs = [
      _song1Controller.text.trim(),
      if (_song2Controller.text.trim().isNotEmpty)
        _song2Controller.text.trim(),
      if (_song3Controller.text.trim().isNotEmpty)
        _song3Controller.text.trim(),
    ];

    final playlist = Playlist(
      id: '',
      mood: mood,
      title: _titleController.text.trim().isEmpty
          ? 'untitled'
          : _titleController.text.trim(),
      songs: songs,
      description: _descriptionController.text.trim().isEmpty
          ? null
          : _descriptionController.text.trim(),
      createdAt: DateTime.now(),
      userId: FirebaseAuth.instance.currentUser!.uid,
    );

    final playlistProvider =
        Provider.of<PlaylistProvider>(context, listen: false);

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
    final String mood =
        (ModalRoute.of(context)?.settings.arguments as String?) ??
            'unknown mood';

    return Scaffold(
      appBar: AppBar(
        title: Text('$mood new playlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, 
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('playlist title'),
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    hintText: 'e.g. late night thoughts',
                  ),
                ),
                const SizedBox(height: 16),
                const Text('song 1 (required)'),
                TextField(
                  controller: _song1Controller,
                  decoration: const InputDecoration(
                    hintText: 'paste your song link',
                  ),
                ),
                const SizedBox(height: 16),
                const Text('song 2'),
                TextField(
                  controller: _song2Controller,
                ),
                const SizedBox(height: 16),
                const Text('song 3'),
                TextField(
                  controller: _song3Controller,
                ),
                const SizedBox(height: 16),
                const Text('description'),
                TextField(
                  controller: _descriptionController,
                  maxLines: 3,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed:
                        _isSaving ? null : () => _savePlaylist(context),
                    child: _isSaving
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
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
