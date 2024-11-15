import 'package:flutter/material.dart';
import 'package:flutter_social/widget/button_component.dart';
import 'package:flutter_social/widget/textfield_component.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  // text controllers
  @override
  Widget build(BuildContext context) {
    TextEditingController test = TextEditingController();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const MyLogo(),
              const SizedBox(height: 20),
              Text(
                "Have we met before or it's your first time?",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              ButtonComponent(onTap: () {}, text: "Log Into My Account"),
              const SizedBox(height: 5),
              ButtonComponent(onTap: () {}, text: "Create My Account")
            ],
          ),
        ),
      ),
    );
  }
}

class MyLogo extends StatelessWidget {
  const MyLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        "assets/logo.png",
        fit: BoxFit.contain,
      ),
    );
  }
}
