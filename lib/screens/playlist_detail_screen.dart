import 'package:flutter/material.dart';

import '../models/playlist.dart';

class PlaylistDetailScreen extends StatelessWidget {
  const PlaylistDetailScreen({super.key});

  @override 
  Widget build(BuildContext context) {
    final playlist = ModalRoute.of(context)?.settings.arguments as Playlist?;

    if (playlist == null) {
      return const Scaffold(
        body: Center(
          child: Text('playlist not found.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(playlist.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              playlist.mood,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
              ),
              if (playlist.description != null && playlist.description!.trim().isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(playlist.description!),
                ),
                const SizedBox(height: 16),
                const Text(
                  'songs',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView.builder(
                    itemCount: playlist.songs.length,
                    itemBuilder: (context, index) {
                      final song = playlist.songs[index];
                      return ListTile(
                        leading: const Icon(Icons.music_note),
                        title: Text(song),
                        //// LINK ADDITION 
                        onTap: (){},
                      );
                    },
                    ),
                )
          ],
        ),
        ),
    );
  }
}