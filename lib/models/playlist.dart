import 'package:cloud_firestore/cloud_firestore.dart';

class Playlist {
  final String id;
  final String mood;
  final String title;
  final List<String> songs;
  final String? description;
  final DateTime createdAt;

  Playlist({
    required this.id,
    required this.mood,
    required this.title,
    required this.songs,
    this.description,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'mood': mood,
      'title': title,
      'songs': songs,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
    };
  }
  factory Playlist.fromDoc(DocumentSnapshot<Map<String,dynamic>> doc) {
    final data = doc.data() ?? {};

    final List<dynamic> songsDynamic = data['songs'] ?? [];
    final List<String> songsList =
    songsDynamic.map((item) => item.toString()).toList();

    final createdAtValue = data['createdAt'];
    DateTime createdAtDate;

    if (createdAtValue is String) {
      createdAtDate = DateTime.tryParse(createdAtValue) ?? DateTime.now();
    } else if (createdAtValue is Timestamp) {
      createdAtDate = createdAtValue.toDate();
    } else {
      createdAtDate = DateTime.now();
    }

    return Playlist(
      id: doc.id,
      mood: data['mood']?.toString() ?? 'mood - unknown',
      title: data['title']?.toString() ?? 'title - unknown',
      songs: songsList,
      description: data['description']?.toString(),
      createdAt: createdAtDate,
    );
  }
}
