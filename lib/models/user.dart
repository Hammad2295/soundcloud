import 'package:cloud_firestore/cloud_firestore.dart';

class UserRecord {
  final String uid;
  final String username;
  final String gender;
  final String photoUrl;

  UserRecord({
    required this.uid,
    required this.username,
    required this.gender,
    this.photoUrl = '',
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'username': username,
      'gender': gender,
      'photoUrl': photoUrl,
    };
  }

  static UserRecord userFromSnapshot(DocumentSnapshot snapshot) {
    return UserRecord(
      uid: snapshot['uid'],
      username: snapshot['username'],
      gender: snapshot['gender'],
      photoUrl: snapshot['photoUrl'],
    );
  }
}
