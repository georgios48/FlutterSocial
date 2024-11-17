import 'package:flutter_social/model/user_model.dart';

abstract class AuthState {}

// initial state
class AuthInitial extends AuthState {}

// loading state
class AuthLoading extends AuthState {}

// authenticated state
class Authenticated extends AuthState {
  final UserModel user;
  Authenticated(this.user);
}

// unauthenticated state
class Unauthenticated extends AuthState {}

// errors
class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}
