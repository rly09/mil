import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mil/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:mil/features/profile/presentation/components/bio_box.dart';
import 'package:mil/features/profile/presentation/cubits/profile_cubit.dart';
import 'package:mil/features/profile/presentation/cubits/profile_states.dart';
import 'package:mil/responsive/constrained_scaffold.dart';
import '../../../auth/domain/entities/app_user.dart';
import 'edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  final String uid;

  const ProfilePage({super.key, required this.uid});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final authCubit = context.read<AuthCubit>();
  late final profileCubit = context.read<ProfileCubit>();
  late AppUser? currentUser = authCubit.currentUser;

  final List<Map<String, dynamic>> dummyPosts = [
    {
      'postImage': 'https://picsum.photos/400/300',
      'caption': 'Exploring Flutter! 🚀',
      'likes': 150,
      'comments': 20,
    },
    {
      'postImage': 'https://picsum.photos/400/301',
      'caption': 'Dark mode looks amazing 🌑',
      'likes': 200,
      'comments': 35,
    },
    {
      'postImage': 'https://picsum.photos/400/302',
      'caption': 'Minimal UI vibes ✨',
      'likes': 120,
      'comments': 10,
    },
  ];

  @override
  void initState() {
    super.initState();
    profileCubit.fetchUserProfile(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoaded) {
          final user = state.profileUser;
          return ConstrainedScaffold(
            appBar: AppBar(
              title: Text(
                user.name,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              foregroundColor: theme.colorScheme.onSurface,
              backgroundColor: theme.colorScheme.surface,
              elevation: 0.5,
              actions: [
                IconButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfilePage(user: user),
                    ),
                  ),
                  icon: Icon(Icons.settings, color: theme.colorScheme.primary),
                ),
              ],
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Profile Picture
                  CircleAvatar(
                    radius: 55,
                    backgroundImage: NetworkImage(
                      user.profileImageUrl.isNotEmpty
                          ? user.profileImageUrl
                          : 'https://i.pravatar.cc/150',
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Email
                  Text(
                    user.email,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Stats Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStat("Posts", dummyPosts.length.toString(), theme),
                      _buildStat("Followers", "1.2k", theme),
                      _buildStat("Following", "180", theme),
                    ],
                  ),

                  const SizedBox(height: 25),

                  // Bio
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Bio",
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  BioBox(text: user.bio),
                  const SizedBox(height: 25),

                  // Posts
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Posts",
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  ListView.builder(
                    itemCount: dummyPosts.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final post = dummyPosts[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: theme.shadowColor.withOpacity(0.05),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Post Image
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(16),
                              ),
                              child: Image.network(
                                post['postImage'],
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),

                            // Caption
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                post['caption'],
                                style: theme.textTheme.bodyMedium,
                              ),
                            ),

                            // Likes & Comments
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.favorite_border,
                                      size: 20,
                                      color: theme.colorScheme.primary),
                                  const SizedBox(width: 6),
                                  Text('${post['likes']}',
                                      style: theme.textTheme.bodySmall),
                                  const SizedBox(width: 16),
                                  Icon(Icons.comment_outlined,
                                      size: 20,
                                      color: theme.colorScheme.primary),
                                  const SizedBox(width: 6),
                                  Text('${post['comments']}',
                                      style: theme.textTheme.bodySmall),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        } else if (state is ProfileLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else {
          return const Scaffold(
            body: Center(child: Text("No profile found...")),
          );
        }
      },
    );
  }

  Widget _buildStat(String label, String count, ThemeData theme) {
    return Column(
      children: [
        Text(
          count,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
      ],
    );
  }
}
