import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<String> getSongUrl({required String songId}) async {
    Reference ref = _firebaseStorage.ref().child('songs').child(songId);

    try {
      String songUrl = await ref.getDownloadURL();
      print(songUrl);
      return songUrl;
    } catch (exception) {
      return '';
    }
  }

  Future<String> uploadSong(
      {required PlatformFile file, required String title}) async {
    try {
      Reference ref = _firebaseStorage.ref().child('songs').child(title);
      await ref.putData(file.bytes!);
      String songUrl = await ref.getDownloadURL();
      print(songUrl);
      return songUrl;
    } catch (exception) {
      return '';
    }
  }

  Future<String> uploadImage(
      {required Uint8List bytes,
      // required String extension,
      required String id,
      required String folder}) async {
    try {
      Reference ref = _firebaseStorage.ref().child(folder).child(id);
      await ref.putData(bytes);
      String songCoverUrl = await ref.getDownloadURL();
      print(songCoverUrl);
      return songCoverUrl;
    } catch (exception) {
      return '';
    }
  }

  Future<String> getImageUrl(
      {required String id, required String folder}) async {
    Reference ref = _firebaseStorage.ref().child(folder).child(id);

    try {
      String songCoverUrl = await ref.getDownloadURL();
      print(songCoverUrl);
      return songCoverUrl;
    } catch (exception) {
      return '';
    }
  }

  Future<bool> deleteSong({required String songId}) async {
    try {
      Reference ref = _firebaseStorage.ref().child('songs').child(songId);
      await ref.delete();
      return true;
    } catch (exception) {
      return false;
    }
  }
}
