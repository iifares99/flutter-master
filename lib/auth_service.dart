// Import FirebaseAuth package
import 'package:firebase_auth/firebase_auth.dart'; 

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Register with email & password
  Future<User?> registerWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password
      );
      return result.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Login with email & password
  Future<User?> loginWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email, password: password
      );
      return result.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
