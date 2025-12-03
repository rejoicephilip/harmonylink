import 'package:flutter/material.dart';

import '../models/playlist.dart';
import '../services/firestore_service.dart';

class PlaylistProvider extends ChangeNotifier {

final FirestoreService _firestoreService = FirestoreService();

bool _isLoading = false;
final List<Playlist> _playlists = [];

bool get isLoading => _isLoading;
List<Playlist> get playlists => List.unmodifiable(_playlists);

Future<void> loadPlaylists() async {
  _isLoading = true;
  notifyListeners();

  try {
    final items = await _firestoreService.getPlaylists();
    _playlists
    ..clear()
    ..addAll(items);
  } catch (e) {
    print('sorry! there was an error loading this playlist. please try again: $e');
  }

  _isLoading = false;
  notifyListeners();
}
Future<void> addPlaylist(Playlist playlist) async {
  try {
    await _firestoreService.addPlaylist(playlist);
    await loadPlaylists();
  } catch (e) {
    print('sorry! there was an error loading this playlist. please try again: $e');
  }
}
}