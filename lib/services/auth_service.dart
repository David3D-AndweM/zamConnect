import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  FirebaseAuth? _auth;
  GoogleSignIn? _googleSignIn;
  bool _isFirebaseInitialized = false;

  AuthService() {
    _initFirebase();
  }

  void _initFirebase() {
    try {
      _auth = FirebaseAuth.instance;
      _googleSignIn = GoogleSignIn();
      _isFirebaseInitialized = true;
    } catch (e) {
      _isFirebaseInitialized = false;
    }
  }

  User? get currentUser => _isFirebaseInitialized ? _auth?.currentUser : null;

  Stream<User?> get authStateChanges =>
      _isFirebaseInitialized ? _auth!.authStateChanges() : Stream.value(null);

  Future<UserCredential?> signInWithEmail(String email, String password) async {
    if (!_isFirebaseInitialized) {
      await Future.delayed(const Duration(seconds: 1));
      return _MockUserCredential();
    }

    return await _auth!.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential?> signUpWithEmail(
    String email,
    String password,
    String name,
  ) async {
    if (!_isFirebaseInitialized) {
      await Future.delayed(const Duration(seconds: 1));
      return _MockUserCredential(name: name, email: email);
    }

    final credential = await _auth!.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    await credential.user?.updateDisplayName(name);
    return credential;
  }

  Future<UserCredential?> signInWithGoogle() async {
    if (!_isFirebaseInitialized) {
      await Future.delayed(const Duration(seconds: 1));
      return _MockUserCredential(name: 'Google User', email: 'google@example.com');
    }

    final googleUser = await _googleSignIn!.signIn();
    if (googleUser == null) return null;

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await _auth!.signInWithCredential(credential);
  }

  Future<UserCredential?> signInAnonymously() async {
    if (!_isFirebaseInitialized) {
      await Future.delayed(const Duration(milliseconds: 500));
      return _MockUserCredential(isAnonymous: true);
    }

    return await _auth!.signInAnonymously();
  }

  Future<void> signOut() async {
    if (!_isFirebaseInitialized) {
      await Future.delayed(const Duration(milliseconds: 300));
      return;
    }

    await _googleSignIn?.signOut();
    await _auth!.signOut();
  }

  Future<void> resetPassword(String email) async {
    if (!_isFirebaseInitialized) {
      await Future.delayed(const Duration(seconds: 1));
      return;
    }

    await _auth!.sendPasswordResetEmail(email: email);
  }

  Future<void> deleteAccount() async {
    if (!_isFirebaseInitialized) return;
    await _auth!.currentUser?.delete();
  }
}

class _MockUserCredential implements UserCredential {
  final String? name;
  final String? email;
  final bool isAnonymous;

  _MockUserCredential({this.name, this.email, this.isAnonymous = false});

  @override
  AdditionalUserInfo? get additionalUserInfo => null;

  @override
  AuthCredential? get credential => null;

  @override
  User? get user => _MockUser(name: name, email: email, isAnonymous: isAnonymous);
}

class _MockUser implements User {
  @override
  final String? displayName;
  @override
  final String? email;
  @override
  final bool isAnonymous;

  _MockUser({String? name, this.email, this.isAnonymous = false})
      : displayName = name;

  @override
  String get uid => 'mock_user_${DateTime.now().millisecondsSinceEpoch}';

  @override
  bool get emailVerified => true;

  @override
  String? get phoneNumber => null;

  @override
  String? get photoURL => null;

  @override
  List<UserInfo> get providerData => [];

  @override
  String? get refreshToken => null;

  @override
  String? get tenantId => null;

  @override
  UserMetadata get metadata => throw UnimplementedError();

  @override
  MultiFactor get multiFactor => throw UnimplementedError();

  @override
  Future<void> delete() async {}

  @override
  Future<String> getIdToken([bool forceRefresh = false]) async => 'mock_token';

  @override
  Future<IdTokenResult> getIdTokenResult([bool forceRefresh = false]) =>
      throw UnimplementedError();

  @override
  Future<UserCredential> linkWithCredential(AuthCredential credential) =>
      throw UnimplementedError();

  @override
  Future<UserCredential> linkWithProvider(AuthProvider provider) =>
      throw UnimplementedError();

  @override
  Future<UserCredential> reauthenticateWithCredential(AuthCredential credential) =>
      throw UnimplementedError();

  @override
  Future<UserCredential> reauthenticateWithProvider(AuthProvider provider) =>
      throw UnimplementedError();

  @override
  Future<void> reload() async {}

  @override
  Future<void> sendEmailVerification([ActionCodeSettings? actionCodeSettings]) async {}

  @override
  Future<User> unlink(String providerId) => throw UnimplementedError();

  @override
  Future<void> updateDisplayName(String? displayName) async {}

  @override
  Future<void> updateEmail(String newEmail) async {}

  @override
  Future<void> updatePassword(String newPassword) async {}

  @override
  Future<void> updatePhoneNumber(PhoneAuthCredential phoneCredential) async {}

  @override
  Future<void> updatePhotoURL(String? photoURL) async {}

  @override
  Future<void> verifyBeforeUpdateEmail(String newEmail,
      [ActionCodeSettings? actionCodeSettings]) async {}

  @override
  Future<UserCredential> linkWithPhoneNumber(String phoneNumber,
      [RecaptchaVerifier? verifier]) =>
      throw UnimplementedError();

  @override
  Future<ConfirmationResult> reauthenticateWithPhoneNumber(String phoneNumber,
      [RecaptchaVerifier? verifier]) =>
      throw UnimplementedError();

  @override
  Future<void> updateProfile({String? displayName, String? photoURL}) async {}
}
