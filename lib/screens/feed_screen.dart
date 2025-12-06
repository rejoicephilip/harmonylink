import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../providers/playlist_provider.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<PlaylistProvider>(context, listen: false).loadPlaylists();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        title: Text(
          'harmonylink',
          style: GoogleFonts.pacifico(
            fontSize: 26,
            color: theme.colorScheme.onPrimary,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.color_lens),
            tooltip: 'change theme',
            onPressed: () {
              Navigator.pushNamed(context, '/theme');
            },
          ),
        ],
      ),
      body: Consumer<PlaylistProvider>(
        builder: (context, playlistProvider, _) {
          final playlists = playlistProvider.filteredPlaylists;

          if (playlistProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: DropdownButtonFormField<String>(
                  value: playlistProvider.selectedMood,
                  decoration: InputDecoration(
                    labelText: 'filter by mood',
                    labelStyle: TextStyle(color: textColor),
                    border: const OutlineInputBorder(),
                  ),
                  style: TextStyle(color: textColor),
                  dropdownColor: theme.colorScheme.surface,
                  iconEnabledColor: textColor,
                  items: const [
                    DropdownMenuItem(value: 'All', child: Text('All')),
                    DropdownMenuItem(value: 'calm & collected', child: Text('calm & collected')),
                    DropdownMenuItem(value: 'low energy', child: Text('low energy')),
                    DropdownMenuItem(value: 'uplifted', child: Text('uplifted')),
                    DropdownMenuItem(value: 'romantic', child: Text('romantic')),
                    DropdownMenuItem(value: 'heartbroken', child: Text('heartbroken')),
                    DropdownMenuItem(value: 'nostalgic', child: Text('nostalgic')),
                    DropdownMenuItem(value: 'party', child: Text('party')),
                    DropdownMenuItem(value: 'focused', child: Text('focused')),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      playlistProvider.setMoodFilter(value);
                    }
                  },
                ),
              ),
              Expanded(
                child: playlists.isEmpty
                    ? Center(
                        child: Text(
                          'no playlists yet. get us started and create yours today!',
                          style: TextStyle(color: textColor),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                        itemCount: playlists.length,
                        itemBuilder: (context, index) {
                          final playlist = playlists[index];

                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/playlistDetail', arguments: playlist);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 16),
                              padding: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.surface.withOpacity(0.95),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: theme.colorScheme.onSurface.withOpacity(0.08),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: theme.shadowColor.withOpacity(0.08),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    playlist.mood,
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: textColor,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    playlist.title,
                                    style: theme.textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: textColor,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    '${playlist.songs.length} songs',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: textColor.withOpacity(0.7),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  if (playlist.description != null &&
                                      playlist.description!.isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        '"${playlist.description}"',
                                        textAlign: TextAlign.center,
                                        style: theme.textTheme.bodySmall?.copyWith(
                                          fontStyle: FontStyle.italic,
                                          color: textColor.withOpacity(0.7),
                                        ),
                                      ),
                                    ),
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.edit, color: textColor),
                                        onPressed: () {
                                          Navigator.pushNamed(
                                            context,
                                            '/addSongs',
                                            arguments: playlist,
                                          );
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete, color: textColor),
                                        onPressed: () {
                                          playlistProvider.deletePlaylist(playlist.id);
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(content: Text('playlist deleted')),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Container(
                                    height: 1,
                                    width: MediaQuery.of(context).size.width * 0.5,
                                    color: theme.colorScheme.primary.withOpacity(0.2),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/moodSelect');
        },
        tooltip: 'create playlist',
        child: const Icon(Icons.add),
      ),
    );
  }
}
