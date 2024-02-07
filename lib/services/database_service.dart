import 'package:souncloud_clone/models/song.dart';
import 'package:souncloud_clone/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserRecord?> getUserRecord() async {
    try {
      DocumentSnapshot userRecord = await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .get();
      UserRecord user = UserRecord.userFromSnapshot(userRecord);
      return user;
    } catch (exception) {
      return null;
    }
  }

  Future createUserRecord({
    required String uid,
    required String username,
    required String gender,
    required String photoUrl,
  }) async {
    try {
      await _firestore.collection('users').doc(uid).set({
        'uid': uid,
        'username': username,
        'gender': gender,
        'photoUrl': photoUrl,
      });
    } catch (exception) {
      return null;
    }
  }

  Future updateUserRecord(
      {required String uid, required String username}) async {
    try {
      await _firestore.collection('users').doc(uid).update({
        'username': username,
      });
    } catch (exception) {
      return null;
    }
  }

  Future createSongRecord({
    required String songId,
    required String title,
    required String artist,
    required String genre,
    required String fileUrl,
    required String coverUrl,
  }) async {
    try {
      await _firestore.collection('songs').doc(songId).set({
        'songId': songId,
        'title': title,
        'genre': genre,
        'artist': artist,
        'fileUrl': fileUrl,
        'coverUrl': coverUrl,
      });
    } catch (exception) {
      return null;
    }
  }

  Future<Song?> getSongRecord({required String title}) async {
    try {
      DocumentSnapshot songRecord =
          await _firestore.collection('songs').doc(title).get();
      Song song = Song.songFromSnapshot(songRecord);
      return song;
    } catch (exception) {
      return null;
    }
  }

  List<Song> _songListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((DocumentSnapshot doc) {
      return Song(
        id: doc['songId'],
        title: doc['title'],
        artist: doc['artist'],
        genre: doc['genre'],
        coverUrl: doc['coverUrl'],
        fileUrl: doc['fileUrl'],
      );
    }).toList();
  }

  Stream<UserRecord> get userRecord {
    return _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .snapshots()
        .map((DocumentSnapshot snapshot) =>
            UserRecord.userFromSnapshot(snapshot));
  }

  // Stream<Song> get songRecord {
  //   return _firestore
  //       .collection('songs')
  //       .doc('songId')
  //       .snapshots()
  //       .map((DocumentSnapshot snapshot) => Song.songFromSnapshot(snapshot));
  // }

  Stream<List<Song>> get songs {
    return _firestore
        .collection('songs')
        .snapshots()
        .map((QuerySnapshot snapshot) => _songListFromSnapshot(snapshot));
  }
}
