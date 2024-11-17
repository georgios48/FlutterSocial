import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_social/auth/auth_cubit.dart';
import 'package:flutter_social/widget/button_component.dart';
import 'package:flutter_social/widget/textfield_component.dart';

class LoginScreen extends StatefulWidget {
  final void Function()? switchPages;

  const LoginScreen({super.key, required this.switchPages});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  void login() {
    final String email = emailTextController.text;
    final String password = passwordTextController.text;

    // if there is password and email
    if (email.isNotEmpty && password.isNotEmpty) {
      // Get Cubit state manager
      final authCubit = context.read<AuthCubit>();

      // Try logging in, else display alert to user
      authCubit.login(email, password);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("'Email' and 'Password' fields cannot be empty")));
    }
  }

  @override
  void dispose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Login Icon
              Center(
                child: Icon(
                  Icons.login_rounded,
                  size: 80,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 15),
              // Email textField
              TextfieldComponent(
                  controller: emailTextController,
                  hintText: "Email",
                  obscureText: false),
              const SizedBox(height: 5),
              // Password textField
              TextfieldComponent(
                  controller: passwordTextController,
                  hintText: "Password",
                  obscureText: true),
              // Forgot password
              const SizedBox(height: 3),
              const _ForgotPasswordButton(),
              const SizedBox(height: 5),
              // Login button
              ButtonComponent(onTap: () => login(), text: "Login"),
              const SizedBox(height: 5),
              // Dont have an account button
              _DontHaveAnAccountButton(widget.switchPages)
            ],
          ),
        ),
      ),
    );
  }
}

class _ForgotPasswordButton extends StatelessWidget {
  const _ForgotPasswordButton();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {},
          child: Text(
            "Forgot Password?",
            style: TextStyle(
              decoration: TextDecoration.underline,
              color: Theme.of(context).colorScheme.primary,
              fontSize: 12,
            ),
          ),
        )
      ],
    );
  }
}

class _DontHaveAnAccountButton extends StatelessWidget {
  final void Function()? switchPages;

  const _DontHaveAnAccountButton(this.switchPages);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: switchPages,
        child: const Text(
          "Don't have an account?",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
