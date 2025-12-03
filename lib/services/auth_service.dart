import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      return result.user;
    } catch (e) {
      print('sorry! this log in attempt was not successful. please try again: $e');
      return null;
    }
  }
  Stream<User?> get userStream {
    return _auth.authStateChanges();
  }
}