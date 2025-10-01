import 'package:flutter/material.dart';
import 'package:mil/responsive/constrained_scaffold.dart';
import '../components/my_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> posts = [
    {
      'username': 'bat_man',
      'profilePic': 'https://i.pravatar.cc/150?img=1',
      'postImage': 'https://picsum.photos/400/300',
      'caption': 'You either die a hero, or live long enough to see yourself become the villain.',
      'likes': 120,
      'comments': 10,
    },
    {
      'username': 'iron_man',
      'profilePic': 'https://i.pravatar.cc/150?img=2',
      'postImage': 'https://picsum.photos/400/301',
      'caption': 'I am Ironman.',
      'likes': 250,
      'comments': 30,
    },
    {
      'username': 'super_man',
      'profilePic': 'https://i.pravatar.cc/150?img=3',
      'postImage': 'https://picsum.photos/400/302',
      'caption': 'Truth, justice and the American way.',
      'likes': 180,
      'comments': 25,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ConstrainedScaffold(
      appBar: AppBar(
        title: Text(
          "F E E D",
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        backgroundColor: theme.colorScheme.surface,
        foregroundColor: theme.colorScheme.onSurface,
        elevation: 0.5,
        centerTitle: true,
      ),
      drawer: const MyDrawer(),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];

          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
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
                // User info
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(post['profilePic']),
                    radius: 22,
                  ),
                  title: Text(
                    post['username'],
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  subtitle: Text(
                    '2h ago',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.more_vert,
                        color: theme.colorScheme.onSurface.withOpacity(0.7)),
                    onPressed: () {},
                  ),
                ),

                // Post image
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    post['postImage'],
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),

                // Caption
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 8.0),
                  child: Text(
                    post['caption'],
                    style: theme.textTheme.bodyMedium?.copyWith(
                      height: 1.4,
                    ),
                  ),
                ),

                // Likes and comments
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Row(
                    children: [
                      Icon(Icons.favorite_border,
                          size: 22, color: theme.colorScheme.primary),
                      const SizedBox(width: 6),
                      Text(
                        '${post['likes']}',
                        style: theme.textTheme.bodySmall,
                      ),
                      const SizedBox(width: 18),
                      Icon(Icons.mode_comment_outlined,
                          size: 22, color: theme.colorScheme.primary),
                      const SizedBox(width: 6),
                      Text(
                        '${post['comments']}',
                        style: theme.textTheme.bodySmall,
                      ),
                      const Spacer(),
                      Icon(Icons.send_outlined,
                          size: 22, color: theme.colorScheme.primary),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          );
        },
      ),
    );
  }
}
