/* 
Used to manage the authentication state of the app
*/

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_social/auth/auth_service.dart';
import 'package:flutter_social/model/user_model.dart';
import 'package:flutter_social/provider/auth_states.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService authService;
  UserModel? _currentUser;

  AuthCubit({required this.authService}) : super(AuthInitial());

  // check if user is already authenticated
  void checkAuth() async {
    final UserModel? user = await authService.getCurrentUser();

    if (user != null) {
      _currentUser = user;
      emit(Authenticated(user));
    } else {
      emit(Unauthenticated());
    }
  }

  // getter for current user
  UserModel? get currentUser => _currentUser;

  // login
  Future<void> login(String email, password) async {
    try {
      emit(AuthLoading());

      final user = await authService.signInWithEmailPw(email, password);

      if (user != null) {
        _currentUser = user;
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(Unauthenticated());
    }
  }

  // register
  Future<void> register(String name, email, password) async {
    try {
      emit(AuthLoading());

      final user = await authService.signUpWithEmailPw(name, email, password);

      if (user != null) {
        _currentUser = user;
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(Unauthenticated());
    }
  }

  //logout
  Future<void> logout() async {
    authService.signOut();
    emit(Unauthenticated());
  }
}
