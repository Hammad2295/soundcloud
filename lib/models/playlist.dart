import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:souncloud_clone/models/song.dart';

class Playlist {
  final String id;
  final String name;
  final String description;
  final String owner;
  List<Song>? songs;

  Playlist({
    required this.id,
    required this.name,
    required this.description,
    required this.owner,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'owner': owner,
      'description': description,
    };
  }

  static Playlist userFromSnapshot(DocumentSnapshot snapshot) {
    return Playlist(
      id: snapshot['id'],
      name: snapshot['name'],
      owner: snapshot['owner'],
      description: snapshot['description'],
    );
  }
}
