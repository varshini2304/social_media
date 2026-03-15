import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/feed_provider.dart';
import '../utils/constants.dart';
import '../widgets/post_card.dart';
import '../widgets/shimmer_post.dart';
import '../widgets/story_widget.dart';
import 'story_viewer_screen.dart';
import 'share_sheet.dart';
import 'messages_screen.dart';
import 'saved_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.onThemeChanged});

  final ValueChanged<bool> onThemeChanged;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    Future.microtask(() => context.read<FeedProvider>().loadInitial());
  }

  void _onScroll() {
    if (_scrollController.position.pixels >
        _scrollController.position.maxScrollExtent - 500) {
      context.read<FeedProvider>().loadMore();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FeedProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 8),
          _GlassTopBar(onThemeChanged: widget.onThemeChanged),
          const SizedBox(height: 12),
          _StoryRail(),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 120),
              itemCount: provider.isLoading
                  ? 4
                  : provider.posts.length + (provider.isLoadingMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (provider.isLoading) {
                  return const ShimmerPost();
                }
                if (provider.isLoadingMore && index == provider.posts.length) {
                  return const ShimmerPost();
                }
                final post = provider.posts[index];
                return PostCard(
                  post: post,
                  onLike: provider.toggleLike,
                  onSave: provider.toggleSave,
                  onShare: () => showShareSheet(context),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _GlassTopBar extends StatelessWidget {
  const _GlassTopBar({required this.onThemeChanged});

  final ValueChanged<bool> onThemeChanged;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isDark ? AppColors.glassDark : AppColors.glassLight,
              border: Border.all(
                color: isDark ? Colors.white10 : Colors.white54,
              ),
            ),
            child: Row(
              children: [
                Text('Varsh', style: Theme.of(context).textTheme.titleLarge),
                const Spacer(),
                _TopIconButton(
                  icon: Icons.brightness_6_rounded,
                  onTap: () => onThemeChanged(!isDark),
                ),
                const SizedBox(width: 8),
                _TopIconButton(
                  icon: Icons.favorite_border,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const _SimpleScaffold(
                        title: 'Saved',
                        child: SavedScreen(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                _TopIconButton(
                  icon: Icons.send_rounded,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const _SimpleScaffold(
                        title: 'Messages',
                        child: MessagesScreen(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TopIconButton extends StatelessWidget {
  const _TopIconButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      radius: 24,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white10
              : Colors.white70,
        ),
        child: Icon(icon, size: 18),
      ),
    );
  }
}

class _StoryRail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final avatars = DemoData.storyAvatars();
    return SizedBox(
      height: 110,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return StoryWidget(
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
        separatorBuilder: (_, __) => const SizedBox(width: 14),
        itemCount: avatars.length,
      ),
    );
  }
}

class _SimpleScaffold extends StatelessWidget {
  const _SimpleScaffold({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: child,
    );
  }
}

