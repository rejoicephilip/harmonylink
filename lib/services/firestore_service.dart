import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/playlist.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _playlistCollection {
    return _db.collection('playlists');
  }
  Future<void> addPlaylist(Playlist playlist) async {
    await _playlistCollection.add(playlist.toMap());
  }

  Future<List<Playlist>> getPlaylists() async {
    final QuerySnapshot = await _playlistCollection
      .orderBy('createdAt', descending: true)
      .get();

    return QuerySnapshot.docs
    .map((doc) => Playlist.fromDoc(doc))
    .toList();
  }
}