import 'dart:ui';

import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../widgets/story_widget.dart';
import 'story_viewer_screen.dart';

class StoriesScreen extends StatelessWidget {
  const StoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final avatars = DemoData.storyAvatars();
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 16),
          Text('Stories', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.85,
              ),
              itemCount: avatars.length,
              itemBuilder: (context, index) {
                return _GlassStoryCard(
                  name: DemoData.storyNames[index % DemoData.storyNames.length],
                  avatarUrl: avatars[index],
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => StoryViewerScreen(
                        name: DemoData.storyNames[index % DemoData.storyNames.length],
                        avatarUrl: avatars[index],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _GlassStoryCard extends StatelessWidget {
  const _GlassStoryCard({
    required this.name,
    required this.avatarUrl,
    required this.onTap,
  });

  final String name;
  final String avatarUrl;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white10
                : Colors.white70,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white24),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedGradientRing(
                size: 78,
                child: CircleAvatar(
                  radius: 34,
                  backgroundImage: NetworkImage(avatarUrl),
                ),
              ),
              const SizedBox(height: 12),
              Text(name, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 6),
              Text('Tap to view', style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ),
    ),
    );
  }
}
