/*
Root level of the app

Database repos:
  - firebase

State management Bloc providers:
  - auth

Check auth state
  - Unauthenticated -> landing page
  - Authenticated -> home page
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_social/auth/auth_cubit.dart';
import 'package:flutter_social/auth/auth_service.dart';
import 'package:flutter_social/provider/auth_states.dart';
import 'package:flutter_social/ui/screen/home_screen.dart';
import 'package:flutter_social/provider/auth_screen.dart';
import 'package:flutter_social/ui/themes/light_mode.dart';

class MainApp extends StatelessWidget {
  // Authentication service
  final authService = AuthService();

  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Return Bloc by providing cubit and trigger the checkAuth method
    return BlocProvider(
      create: (context) => AuthCubit(authService: authService)..checkAuth(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightMode,
        // Provide a Cubit for the consumer, which is looking at the AuthStates
        home: BlocConsumer<AuthCubit, AuthState>(
          builder: (context, authState) {
            // Unauthenticated -> landing screen
            if (authState is Unauthenticated) {
              return const AuthScreen();
            }
            // Authenticated -> home screen
            if (authState is Authenticated) {
              return const HomeScreen();
              // Loading -> Circular widget
            } else {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
          listener: (context, listenerState) {
            // Listen and notify if errors show up
            if (listenerState is AuthError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(listenerState.message)));
            }
          },
        ),
      ),
    );
  }
}
