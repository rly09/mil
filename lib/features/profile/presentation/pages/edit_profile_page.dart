import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mil/features/auth/presentation/components/my_text_field.dart';
import 'package:mil/features/profile/domain/entities/profile_user.dart';
import 'package:mil/features/profile/presentation/cubits/profile_cubit.dart';
import 'package:mil/features/profile/presentation/cubits/profile_states.dart';
import 'package:mil/responsive/constrained_scaffold.dart';

class EditProfilePage extends StatefulWidget {
  final ProfileUser user;

  const EditProfilePage({super.key, required this.user});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController bioTextController;

  @override
  void initState() {
    super.initState();
    bioTextController = TextEditingController(text: widget.user.bio);
  }

  void updateProfile() {
    final profileCubit = context.read<ProfileCubit>();
    FocusScope.of(context).unfocus(); // close keyboard
    if (bioTextController.text.trim().isNotEmpty) {
      profileCubit.updateProfile(
        uid: widget.user.uid,
        newBio: bioTextController.text.trim(),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Bio cannot be empty")),
      );
    }
  }

  @override
  void dispose() {
    bioTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileLoaded) {
          Navigator.pop(context);
        } else if (state is ProfileError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        if (state is ProfileLoading) {
          return ConstrainedScaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 10),
                  Text("Updating..."),
                ],
              ),
            ),
          );
        } else {
          return buildEditPage();
        }
      },
    );
  }

  Widget buildEditPage() {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        foregroundColor: theme.colorScheme.primary,
        actions: [
          IconButton(
            onPressed: updateProfile,
            icon: Icon(Icons.check, color: theme.colorScheme.primary),
            tooltip: "Save",
          ),
        ],
        backgroundColor: theme.colorScheme.surface,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Bio', style: theme.textTheme.titleMedium),
            const SizedBox(height: 10),
            MyTextField(
              controller: bioTextController,
              hintText: "Enter your bio",
              obscureText: false,
            ),
          ],
        ),
      ),
    );
  }
}
