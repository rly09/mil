import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mil/features/auth/presentation/components/my_button.dart';
import 'package:mil/features/auth/presentation/components/my_text_field.dart';
import 'package:mil/responsive/constrained_scaffold.dart';
import '../cubits/auth_cubit.dart';

class LoginPage extends StatefulWidget {
  final void Function()? togglePages;

  const LoginPage({super.key, required this.togglePages});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final pwController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    pwController.dispose();
    super.dispose();
  }

  void login() {
    final String email = emailController.text;
    final String pw = pwController.text;
    final authCubit = context.read<AuthCubit>();

    if (email.isNotEmpty && pw.isNotEmpty) {
      authCubit.login(email, pw);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter both email and password')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ConstrainedScaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Lottie Animation
                  Lottie.asset(
                    'assets/animations/auth.json',
                    height: 160,
                  ),

                  const SizedBox(height: 35),

                  // Title
                  Text(
                    "Welcome Back!",
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.primary,
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Email TextField
                  MyTextField(
                    controller: emailController,
                    hintText: "Email",
                    obscureText: false,
                  ),
                  const SizedBox(height: 15),

                  // Password TextField
                  MyTextField(
                    controller: pwController,
                    hintText: "Password",
                    obscureText: true,
                  ),

                  const SizedBox(height: 25),

                  // Login Button
                  MyButton(
                    onTap: login,
                    text: "Log in",
                  ),

                  const SizedBox(height: 40),

                  // Divider with "or"
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.7,
                          color: theme.colorScheme.onSurface.withOpacity(0.3),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          "or",
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color:
                            theme.colorScheme.onSurface.withOpacity(0.6),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.7,
                          color: theme.colorScheme.onSurface.withOpacity(0.3),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // Register Redirect
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Not a member?",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: theme.colorScheme.onSurface.withOpacity(0.7),
                        ),
                      ),
                      GestureDetector(
                        onTap: widget.togglePages,
                        child: Text(
                          " Register Now",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
