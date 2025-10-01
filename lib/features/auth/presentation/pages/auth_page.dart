import 'package:flutter/material.dart';
import 'package:mil/features/auth/presentation/pages/login_page.dart';
import 'package:mil/features/auth/presentation/pages/register_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showLoginPage = true;

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: showLoginPage
            ? LoginPage(togglePages: togglePages, key: const ValueKey('Login'))
            : RegisterPage(togglePages: togglePages, key: const ValueKey('Register')),
      ),
    );
  }
}
