import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../models/playlist.dart';
import '../providers/playlist_provider.dart';


class PlaylistDetailScreen extends StatelessWidget {
  const PlaylistDetailScreen({super.key});

  @override 
  Widget build(BuildContext context) {
    final playlist = ModalRoute.of(context)?.settings.arguments as Playlist?;
    final currentUser = FirebaseAuth.instance.currentUser;

    if (playlist == null) {
      return const Scaffold(
        body: Center(
          child: Text('playlist not found.'),
        ),
      );
    }

    final isOwner = currentUser?.uid == playlist.userId;

    return Scaffold(
      appBar: AppBar(
        title: Text(playlist.title),
      actions: [
        if (isOwner)
        IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () async {
            final confirmed = await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('are you sure you want to delete this playlist?'),
                content: const Text('you will not be able to recover it once deleted.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('i want to keep it playlist!'),
                    ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, true), 
                    child: const Text('yes im sure delete my playlist'),
                    )
                ],
              )
            );
            if (confirmed == true) {
              final provider = Provider.of<PlaylistProvider>(context, listen: false);
              await provider.deletePlaylist(playlist.id);
              if (context.mounted) {
                Navigator.pop(context);
              }
            }
          },
        )
      ],
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