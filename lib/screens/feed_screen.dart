import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/playlist_provider.dart';
import '../models/playlist.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  void initState() {
    super.initState();
    final playlistProvider =
    Provider.of<PlaylistProvider>(context, listen: false);
    playlistProvider.loadPlaylists();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('harmonylink feed'),
      ),
            body: Consumer<PlaylistProvider>(
        builder: (context, playlistProvider, child) {

          if (playlistProvider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }


          final List<Playlist> playlists = playlistProvider.playlists;

          if (playlists.isEmpty) {
            return const Center(
              child: Text(
                'no playlists yet. get us started and create yours today!',
              ),
            );
          }

          return ListView.builder(
            itemCount: playlists.length,
            itemBuilder: (context, index) {
              final playlist = playlists[index];
              return ListTile(
                title: Text(playlist.title),
                subtitle: Text(
                  '${playlist.mood} + ${playlist.songs.length} songs',
                ),
                onTap: () {
                  Navigator.pushNamed(
                    context, '/playlistDetail',
                    arguments: playlist,
                   );
                },
              );
            },
          );
        },
      ),
    );
  }
}
