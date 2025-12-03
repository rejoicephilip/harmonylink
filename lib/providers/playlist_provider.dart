import 'package:flutter/material.dart';

class PlaylistProvider extends ChangeNotifier {
  // CHANGE LATER
  List<String> _playlists = [];

  List<String> get playlists => _playlists;

  void addPlaylist(String name) {
    _playlists.add(name);
    notifyListeners();
  }
}