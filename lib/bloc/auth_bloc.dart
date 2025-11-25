import 'package:bloc/bloc.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';
import '../models/user_model.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService;
  final FirestoreService _firestoreService;

  AuthBloc({
    AuthService? authService,
    FirestoreService? firestoreService,
  })  : _authService = authService ?? AuthService(),
        _firestoreService = firestoreService ?? FirestoreService(),
        super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<SignupEvent>(_onSignup);
    on<GoogleAuthEvent>(_onGoogleAuth);
    on<GuestLoginEvent>(_onGuestLogin);
    on<LogoutEvent>(_onLogout);
    on<ResetAuthEvent>(_onResetAuth);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final result = await _authService.signInWithEmail(event.email, event.password);
      if (result != null) {
        emit(AuthSuccess());
      } else {
        emit(const AuthError('Login failed. Please check your credentials.'));
      }
    } catch (e) {
      emit(AuthError(_getErrorMessage(e.toString())));
    }
  }

  Future<void> _onSignup(SignupEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final result = await _authService.signUpWithEmail(
        event.email,
        event.password,
        event.name,
      );

      if (result != null && result.user != null) {
        final userModel = UserModel(
          uid: result.user!.uid,
          name: event.name,
          email: event.email,
          createdAt: DateTime.now(),
        );
        await _firestoreService.createUserProfile(userModel);
        emit(AuthSuccess());
      } else {
        emit(const AuthError('Signup failed. Please try again.'));
      }
    } catch (e) {
      emit(AuthError(_getErrorMessage(e.toString())));
    }
  }

  Future<void> _onGoogleAuth(GoogleAuthEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final result = await _authService.signInWithGoogle();
      if (result != null && result.user != null) {
        final user = result.user!;
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
        emit(AuthSuccess());
      } else {
        emit(const AuthError('Google Sign-In was cancelled.'));
      }
    } catch (e) {
      emit(AuthError(_getErrorMessage(e.toString())));
    }
  }

  Future<void> _onGuestLogin(GuestLoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final result = await _authService.signInAnonymously();
      if (result != null) {
        emit(AuthSuccess());
      } else {
        emit(const AuthError('Guest login failed.'));
      }
    } catch (e) {
      emit(AuthError(_getErrorMessage(e.toString())));
    }
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    try {
      await _authService.signOut();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthError(_getErrorMessage(e.toString())));
    }
  }

  void _onResetAuth(ResetAuthEvent event, Emitter<AuthState> emit) {
    emit(AuthInitial());
  }

  String _getErrorMessage(String error) {
    if (error.contains('user-not-found')) {
      return 'No user found with this email.';
    } else if (error.contains('wrong-password')) {
      return 'Incorrect password.';
    } else if (error.contains('email-already-in-use')) {
      return 'This email is already registered.';
    } else if (error.contains('weak-password')) {
      return 'Password is too weak.';
    } else if (error.contains('invalid-email')) {
      return 'Invalid email address.';
    } else if (error.contains('user-disabled')) {
      return 'This account has been disabled.';
    } else if (error.contains('too-many-requests')) {
      return 'Too many attempts. Please try again later.';
    } else if (error.contains('network-request-failed')) {
      return 'Network error. Please check your connection.';
    }
    return 'An error occurred. Please try again.';
  }
}
