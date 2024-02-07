import 'package:cloud_firestore/cloud_firestore.dart';

class Song {
  final String id;
  final String title;
  final String genre;
  final String artist;
  final String fileUrl;
  final String? coverUrl;

  Song({
    required this.id,
    required this.title,
    required this.genre,
    required this.artist,
    required this.fileUrl,
    this.coverUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'genre': genre,
      'artist': artist,
      'fileUrl': fileUrl,
      'thumbnailUrl': coverUrl,
    };
  }

  static Song songFromSnapshot(DocumentSnapshot snapshot) {
    return Song(
      id: snapshot['id'],
      title: snapshot['title'],
      genre: snapshot['genre'],
      artist: snapshot['artist'],
      fileUrl: snapshot['fileUrl'],
      coverUrl: snapshot['thumbnailUrl'],
    );
  }
}
