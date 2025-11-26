import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  User? get currentUser => _firebaseAuth.currentUser;

  Future<void> signInWithEmail(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> signUpWithEmail(String email, String password, String name) async {
    print('Attempting signup with email: $email, password length: ${password.length}, name: $name');
    try {
      UserCredential credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user != null) {
        await credential.user!.updateDisplayName(name);
      }
      return credential;
    } on FirebaseAuthException catch (e) {
      print('AuthService signup FirebaseAuthException:');
      print('  Code: ${e.code}');
      print('  Message: ${e.message}');
      print('  Plugin: ${e.plugin}');
      print('  Stack trace: ${e.stackTrace}');
      if (e.code == 'internal-error') {
        print('INTERNAL ERROR - Possible causes:');
        print('  1. Email/Password authentication not enabled in Firebase Console');
        print('  2. API key restrictions in Google Cloud Console');
        print('  3. Firebase project configuration issue');
      }
      rethrow;
    } catch (e) {
      print('AuthService signup error: $e');
      rethrow;
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await _firebaseAuth.signInWithCredential(credential);
    } catch (e) {
      print('Error signing in with Google: $e');
      rethrow;
    }
  }

  Future<void> signInAnonymously() async {
    await _firebaseAuth.signInAnonymously();
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }
}
