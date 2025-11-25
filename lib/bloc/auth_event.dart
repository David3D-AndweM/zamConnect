import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;
  final bool keepSignedIn;

  const LoginEvent({
    required this.email,
    required this.password,
    required this.keepSignedIn,
  });

  @override
  List<Object> get props => [email, password, keepSignedIn];
}

class SignupEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final bool agreeToTerms;

  const SignupEvent({
    required this.name,
    required this.email,
    required this.password,
    required this.agreeToTerms,
  });

  @override
  List<Object> get props => [name, email, password, agreeToTerms];
}

class GoogleAuthEvent extends AuthEvent {
  const GoogleAuthEvent();
}

class GuestLoginEvent extends AuthEvent {
  const GuestLoginEvent();
}

class ResetAuthEvent extends AuthEvent {
  const ResetAuthEvent();
}