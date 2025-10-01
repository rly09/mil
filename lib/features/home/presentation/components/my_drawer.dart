import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../auth/presentation/cubits/auth_cubit.dart';
import 'my_drawer_tile.dart';
import '../../../profile/presentation/pages/profile_page.dart';
import '../../../../themes/theme.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authCubit = context.read<AuthCubit>();
    final user = authCubit.currentUser;

    return Drawer(
      backgroundColor: theme.colorScheme.surface,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            children: [
              const SizedBox(height: 30),

              // User Info
              Column(
                children: [
                  CircleAvatar(
                    radius: 42,
                    backgroundImage: NetworkImage(
                      user?.profilePhoto ?? 'https://i.pravatar.cc/150',
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    user?.name ?? "Guest",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 35),
              Divider(
                color: theme.colorScheme.secondary.withOpacity(0.5),
                thickness: 0.8,
              ),
              const SizedBox(height: 20),

              // Drawer items
              MyDrawerTile(
                title: "H O M E",
                icon: Icons.home_rounded,
                onTap: () => Navigator.of(context).pop(),
              ),
              MyDrawerTile(
                title: "P R O F I L E",
                icon: Icons.person_rounded,
                onTap: () {
                  Navigator.of(context).pop();
                  if (user != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfilePage(uid: user.uid),
                      ),
                    );
                  }
                },
              ),
              MyDrawerTile(
                title: "S E A R C H",
                icon: Icons.search_rounded,
                onTap: () {},
              ),
              MyDrawerTile(
                title: "S E T T I N G S",
                icon: Icons.settings_rounded,
                onTap: () {},
              ),

              const Spacer(),

              // Dark/Light Mode Toggle
              Consumer<ThemeProvider>(
                builder: (context, themeProvider, _) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.light_mode,
                          size: 20, color: theme.colorScheme.primary),
                      Switch(
                        value: themeProvider.isDarkMode,
                        activeColor: theme.colorScheme.primary,
                        onChanged: (val) {
                          themeProvider.toggleTheme();
                        },
                      ),
                      Icon(Icons.dark_mode,
                          size: 20, color: theme.colorScheme.primary),
                    ],
                  );
                },
              ),

              const SizedBox(height: 10),

              MyDrawerTile(
                title: "L O G O U T",
                icon: Icons.logout_rounded,
                onTap: () => authCubit.logout(),
              ),

              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
