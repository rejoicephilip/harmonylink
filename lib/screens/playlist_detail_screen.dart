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
    final theme = Theme.of(context);
    final onSurface = theme.colorScheme.onSurface;
    final playlist = ModalRoute.of(context)?.settings.arguments as Playlist?;
    final currentUser = FirebaseAuth.instance.currentUser;

    if (playlist == null) {
      return Scaffold(
        body: Center(
          child: Text('playlist not found.', style: TextStyle(color: onSurface)),
        ),
      );
    }

    final isOwner = currentUser?.uid == playlist.userId;

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        title: Text(playlist.title, style: TextStyle(color: theme.colorScheme.onPrimary)),
        actions: [
          if (isOwner)
            IconButton(
              icon: const Icon(Icons.edit),
              tooltip: 'add songs',
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
                    ),
                  ],
                ),
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
        child: Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface.withOpacity(0.95),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: theme.shadowColor.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'playlist name: ${playlist.title}',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: onSurface,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'mood selected: ${playlist.mood}',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: onSurface,
                ),
              ),
              if (playlist.description != null && playlist.description!.trim().isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    '"${playlist.description!}"',
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontStyle: FontStyle.italic,
                      color: onSurface.withOpacity(0.7),
                    ),
                  ),
                ),
              const SizedBox(height: 16),
              Text(
                'songs',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: onSurface,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.separated(
                  itemCount: playlist.songs.length,
                  separatorBuilder: (_, __) => const Divider(height: 0),
                  itemBuilder: (context, index) {
                    final songData = playlist.songs[index];
                    final song = songData is Map<String, dynamic> ? songData : {};
                    final songTitle = song['title'] ?? 'untitled';
                    final songLink = song['link'] ?? '';

                    return ListTile(
                      leading: Icon(Icons.music_note, color: onSurface),
                      title: Text(
                        songTitle,
                        style: TextStyle(color: onSurface),
                      ),
                      subtitle: Text(
                        songLink.isNotEmpty ? 'tap to open' : 'no link provided',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: onSurface.withOpacity(0.7),
                        ),
                      ),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
