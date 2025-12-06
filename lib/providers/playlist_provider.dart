import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/playlist.dart';
import '../services/firestore_service.dart';


class PlaylistProvider extends ChangeNotifier {

final FirestoreService _firestoreService = FirestoreService();
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

bool _isLoading = false;
final List<Playlist> _playlists = [];

bool get isLoading => _isLoading;
List<Playlist> get playlists => List.unmodifiable(_playlists);

String _selectedMood = 'All';

String get selectedMood => _selectedMood;

void setMoodFilter(String mood) {
  _selectedMood = mood;
  notifyListeners();
}

List<Playlist> get filteredPlaylists {
  if (_selectedMood == 'All') return _playlists;
  return _playlists.where((p) => p.mood == _selectedMood).toList();
}


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

Future<void> updatePlaylist(Playlist updatedPlaylist) async {
  await _firestore
      .collection('playlists')
      .doc(updatedPlaylist.id)
      .update(updatedPlaylist.toMap());


  final index = _playlists.indexWhere((p) => p.id == updatedPlaylist.id);
  if (index != -1) {
    _playlists[index] = updatedPlaylist;
    notifyListeners();
  }
}


Future<void> addPlaylist(Playlist playlist) async {
  try {
    await _firestoreService.addPlaylist(playlist);
    await loadPlaylists();
  } catch (e) {
    print('sorry! there was an error loading this playlist. please try again: $e');
  }
}

Future<void> deletePlaylist(String id) async {
  try {
    await _firestoreService.deletePlaylist(id);
    _playlists.removeWhere((playlist) => playlist.id == id);
    notifyListeners();
  } catch (e) {
    print('sorry! playlist cannot be deleted: $e');
  }
}
}