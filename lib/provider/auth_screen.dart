import 'package:flutter/material.dart';
import 'package:flutter_social/ui/screen/login_screen.dart';
import 'package:flutter_social/ui/screen/register_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _showLoginScreen = false;

  void switchPages() {
    setState(() {
      _showLoginScreen = !_showLoginScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_showLoginScreen) {
      return LoginScreen(switchPages: switchPages);
    }
    return RegisterScreen(switchPages: switchPages);
  }
}
