import 'package:bloc/bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
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
      // TODO: Replace with Firebase authentication
      await Future.delayed(const Duration(seconds: 2));
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError('Login failed: ${e.toString()}'));
    }
  }

  Future<void> _onSignup(SignupEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      // TODO: Replace with Firebase authentication
      await Future.delayed(const Duration(seconds: 2));
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError('Signup failed: ${e.toString()}'));
    }
  }

  Future<void> _onGoogleAuth(GoogleAuthEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      // TODO: Implement Google Sign-In
      await Future.delayed(const Duration(seconds: 2));
      emit(const AuthError('Google Sign-In not implemented yet'));
    } catch (e) {
      emit(AuthError('Google Sign-In failed: ${e.toString()}'));
    }
  }

  Future<void> _onGuestLogin(GuestLoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      // TODO: Implement anonymous authentication
      await Future.delayed(const Duration(seconds: 1));
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError('Guest login failed: ${e.toString()}'));
    }
  }

  void _onResetAuth(ResetAuthEvent event, Emitter<AuthState> emit) {
    emit(AuthInitial());
  }
}