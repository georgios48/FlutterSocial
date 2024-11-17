import 'package:flutter/material.dart';

class ButtonComponent extends StatelessWidget {
  final void Function()? onTap;
  final String text;

  const ButtonComponent({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.secondary, // Button background color
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius:
            BorderRadius.circular(12), // Matches the container's borderRadius
        splashColor: Theme.of(context)
            .colorScheme
            .primary
            .withOpacity(0.2), // Customize splash color
        highlightColor: Theme.of(context)
            .colorScheme
            .primary
            .withOpacity(0.1), // Customize highlight color
        child: Container(
          padding: const EdgeInsets.all(25),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors
                    .white, // Text color (optional, depending on your theme)
              ),
            ),
          ),
        ),
      ),
    );
  }
}
