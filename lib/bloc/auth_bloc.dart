import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';
import '../models/user_model.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService = AuthService();
  final FirestoreService _firestoreService = FirestoreService();

  AuthBloc() : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<SignupEvent>(_onSignup);
    on<GoogleAuthEvent>(_onGoogleAuth);
    on<GuestLoginEvent>(_onGuestLogin);
    on<ResetAuthEvent>(_onResetAuth);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _authService.signInWithEmail(event.email, event.password);
      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthError(_getErrorMessage(e.code)));
    } catch (e) {
      emit(AuthError('Login failed. Please try again.'));
    }
  }

  Future<void> _onSignup(SignupEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final credential = await _authService.signUpWithEmail(
        event.email,
        event.password,
        event.name,
      );

      if (credential.user != null) {
        final userModel = UserModel(
          uid: credential.user!.uid,
          name: event.name,
          email: event.email,
          createdAt: DateTime.now(),
        );
        await _firestoreService.createUserProfile(userModel);
      }

      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthError(_getErrorMessage(e.code)));
    } catch (e) {
      emit(AuthError('Signup failed. Please try again.'));
    }
  }

  Future<void> _onGoogleAuth(GoogleAuthEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final credential = await _authService.signInWithGoogle();
      if (credential == null) {
        emit(const AuthError('Google Sign-In was cancelled.'));
        return;
      }

      final user = credential.user;
      if (user != null) {
        final existingUser = await _firestoreService.getUserProfile(user.uid);
        if (existingUser == null) {
          final userModel = UserModel(
            uid: user.uid,
            name: user.displayName ?? 'User',
            email: user.email ?? '',
            photoUrl: user.photoURL,
            createdAt: DateTime.now(),
          );
          await _firestoreService.createUserProfile(userModel);
        }
      }

      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError('Google Sign-In failed. Please try again.'));
    }
  }

  Future<void> _onGuestLogin(GuestLoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _authService.signInAnonymously();
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError('Guest login failed. Please try again.'));
    }
  }

  void _onResetAuth(ResetAuthEvent event, Emitter<AuthState> emit) {
    emit(AuthInitial());
  }

  String _getErrorMessage(String code) {
    switch (code) {
      case 'user-not-found':
        return 'No user found with this email.';
      case 'wrong-password':
        return 'Incorrect password.';
      case 'email-already-in-use':
        return 'This email is already registered.';
      case 'weak-password':
        return 'Password is too weak.';
      case 'invalid-email':
        return 'Invalid email address.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      default:
        return 'An error occurred. Please try again.';
    }
  }
}
