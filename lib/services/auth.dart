import 'package:firebase_auth/firebase_auth.dart';

class AuthencationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User>? get user {
    return _auth.authStateChanges().map((User? user) => user!);
  }

  Future signInWithEmailAndPassword(
      {String email = '', String password = ''}) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user!;
      return user;
    } catch (exception) {
      return null;
    }
  }

  Future registerUserWithEmailAndPassword(
      {String email = '', String password = ''}) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user!;
      return user;
    } catch (exception) {
      return null;
    }
  }

  Future signOut() async {
    try {
      await _auth.signOut();
    } catch (exception) {
      return null;
    }
  }
}
