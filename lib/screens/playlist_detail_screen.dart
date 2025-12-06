import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';


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
        icon: const Icon(Icons.edit),
        tooltip: 'Add songs',
        onPressed: () async {
          final newSongs = await Navigator.pushNamed(context, '/addSongs');
          if (newSongs is List<Map<String, String>> && newSongs.isNotEmpty) {
            final provider = Provider.of<PlaylistProvider>(context, listen: false);
            final updatedPlaylist = Playlist(
              id: playlist.id,
              mood: playlist.mood,
              title: playlist.title,
              songs: [...playlist.songs, ...newSongs],
              description: playlist.description,
              createdAt: playlist.createdAt,
              userId: playlist.userId,
            );

            await provider.updatePlaylist(updatedPlaylist);

            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('songs added to playlist')),
              );
            }
          }
        },
      ),

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
                     final songData = playlist.songs[index];
                    final song = songData is Map ? songData : {}; 
                    final songTitle = song['title'] ?? 'untitled';
                    final songLink = song['link'] ?? '';
                      return ListTile(
                        leading: const Icon(Icons.music_note),
                        title: Text(songTitle),
                        subtitle: Text(songLink.isNotEmpty ? 'tap to open' : 'no link provided'),
                        onTap: () async {
                          if (songLink.isNotEmpty) {
                            final Uri url = Uri.parse(songLink);
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url, mode: LaunchMode.externalApplication);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('could not open link')),
                              );
                            }
                          }
                        },
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