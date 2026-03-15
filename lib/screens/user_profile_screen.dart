import 'package:flutter/material.dart';

import '../models/post_model.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({
    super.key,
    required this.username,
    required this.avatarUrl,
    required this.posts,
  });

  final String username;
  final String avatarUrl;
  final List<Post> posts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(username)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              CircleAvatar(radius: 36, backgroundImage: NetworkImage(avatarUrl)),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(username, style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 6),
                    Text('Creative storyteller',
                        style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Follow'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final image = posts[index].images.first;
              return ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(image, fit: BoxFit.cover),
              );
            },
          ),
        ],
      ),
    );
  }
}
