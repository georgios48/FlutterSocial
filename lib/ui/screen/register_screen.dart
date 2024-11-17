import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_social/auth/auth_cubit.dart';
import 'package:flutter_social/widget/button_component.dart';
import 'package:flutter_social/widget/textfield_component.dart';

class RegisterScreen extends StatefulWidget {
  final void Function()? switchPages;

  const RegisterScreen({super.key, required this.switchPages});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController nameTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void register() {
    final String email = emailTextController.text;
    final String name = nameTextController.text;
    final String password = passwordTextController.text;
    final String confirmPassword = confirmPasswordController.text;

    // if there is password and email
    if (email.isNotEmpty && password.isNotEmpty && name.isNotEmpty) {
      // Check if passwords match
      if (password == confirmPassword) {
        // Get Cubit state manager
        final authCubit = context.read<AuthCubit>();

        // Try logging in, else display alert to user
        authCubit.register(name, email, password);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Passwords do not match")));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("All fields are required")));
    }
  }

  @override
  void dispose() {
    emailTextController.dispose();
    nameTextController.dispose();
    passwordTextController.dispose();
    confirmPasswordController.dispose();
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
                  Icons.app_registration_rounded,
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
              TextfieldComponent(
                  controller: nameTextController,
                  hintText: "Name",
                  obscureText: false),
              const SizedBox(height: 5),
              // Password textField
              TextfieldComponent(
                  controller: passwordTextController,
                  hintText: "Password",
                  obscureText: true),
              // Forgot password
              const SizedBox(height: 5),
              TextfieldComponent(
                  controller: confirmPasswordController,
                  hintText: "Confirm Password",
                  obscureText: true),
              const SizedBox(height: 5),
              // Login button
              ButtonComponent(onTap: () => register(), text: "Register"),
              const SizedBox(height: 5),
              // Aleady have an account button
              _AleadyHaveAnAccountButton(widget.switchPages)
            ],
          ),
        ),
      ),
    );
  }
}

class _AleadyHaveAnAccountButton extends StatelessWidget {
  final void Function()? switchPages;

  const _AleadyHaveAnAccountButton(this.switchPages);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: switchPages,
        child: const Text(
          "Already have an account?",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
