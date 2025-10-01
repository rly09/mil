import 'package:flutter/material.dart';

class BioBox extends StatelessWidget {
  final String text;

  const BioBox({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        color: theme.colorScheme.secondary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text.isNotEmpty ? text : "Empty bio ...",
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSecondary,
        ),
      ),
    );
  }
}
