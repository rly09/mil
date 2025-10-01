import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mil/responsive/constrained_scaffold.dart';

import '../components/my_button.dart';
import '../components/my_text_field.dart';
import '../cubits/auth_cubit.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? togglePages;

  const RegisterPage({super.key, required this.togglePages});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final pwController = TextEditingController();
  final confirmPwController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    pwController.dispose();
    confirmPwController.dispose();
    super.dispose();
  }

  void register() {
    final String name = nameController.text;
    final String email = emailController.text;
    final String pw = pwController.text;
    final String confirmPw = confirmPwController.text;
    final authCubit = context.read<AuthCubit>();

    if (name.isNotEmpty &&
        email.isNotEmpty &&
        pw.isNotEmpty &&
        confirmPw.isNotEmpty) {
      if (pw == confirmPw) {
        authCubit.register(name, email, pw);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Passwords do not match')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
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
                  // Lottie animation
                  Lottie.asset('assets/animations/auth.json', height: 160),

                  const SizedBox(height: 35),

                  // Title
                  Text(
                    "Create an Account",
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.primary,
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Name
                  MyTextField(
                    controller: nameController,
                    hintText: "Name",
                    obscureText: false,
                  ),
                  const SizedBox(height: 15),

                  // Email
                  MyTextField(
                    controller: emailController,
                    hintText: "Email",
                    obscureText: false,
                  ),
                  const SizedBox(height: 15),

                  // Password
                  MyTextField(
                    controller: pwController,
                    hintText: "Password",
                    obscureText: true,
                  ),
                  const SizedBox(height: 15),

                  // Confirm Password
                  MyTextField(
                    controller: confirmPwController,
                    hintText: "Confirm Password",
                    obscureText: true,
                  ),

                  const SizedBox(height: 25),

                  // Register Button
                  MyButton(onTap: register, text: "Register"),

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

                  // Redirect to Login
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already a member?",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: theme.colorScheme.onSurface.withOpacity(0.7),
                        ),
                      ),
                      GestureDetector(
                        onTap: widget.togglePages,
                        child: Text(
                          " Login Now",
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
