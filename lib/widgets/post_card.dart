import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/post_model.dart';
import '../utils/constants.dart';
import 'carousel_widget.dart';
import 'like_button.dart';
import '../screens/comments_screen.dart';
import '../screens/user_profile_screen.dart';

class PostCard extends StatefulWidget {
  const PostCard({
    super.key,
    required this.post,
    required this.onLike,
    required this.onSave,
    required this.onShare,
  });

  final Post post;
  final ValueChanged<Post> onLike;
  final ValueChanged<Post> onSave;
  final VoidCallback onShare;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> with TickerProviderStateMixin {
  int _pageIndex = 0;
  late final AnimationController _likeController;
  late final AnimationController _burstController;

  @override
  void initState() {
    super.initState();
    _likeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0.7,
      upperBound: 1.2,
    )..value = 1.0;
    _burstController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..value = 1.0;
  }

  @override
  void dispose() {
    _likeController.dispose();
    _burstController.dispose();
    super.dispose();
  }

  void _doubleTapLike() {
    if (!widget.post.isLiked) {
      widget.onLike(widget.post);
    }
    _burstController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(26),
        child: Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface.withOpacity(0.9),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _PostHeader(
                    post: widget.post,
                    onProfileTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => UserProfileScreen(
                          username: widget.post.username,
                          avatarUrl: widget.post.userAvatar,
                          posts: [widget.post],
                        ),
                      ),
                    ),
                    onMoreTap: () => _showPostOptions(context),
                  ),
                  const SizedBox(height: 8),
                  CarouselWidget(
                    post: widget.post,
                    onPageChanged: (value) => setState(() => _pageIndex = value),
                    onDoubleTap: _doubleTapLike,
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        ScaleTransition(
                          scale: _likeController,
                          child: LikeButton(
                            isLiked: widget.post.isLiked,
                            onTap: () {
                              HapticFeedback.lightImpact();
                              final wasLiked = widget.post.isLiked;
                              widget.onLike(widget.post);
                              _likeController.forward(from: 0.8);
                              if (!wasLiked) {
                                _burstController.forward(from: 0);
                              }
                            },
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const CommentsScreen(),
                            ),
                          ),
                          icon: const Icon(Icons.mode_comment_outlined),
                        ),
                        IconButton(
                          onPressed: widget.onShare,
                          icon: const Icon(Icons.near_me_outlined),
                        ),
                        const Spacer(),
                        _GlowingSaveButton(
                          isSaved: widget.post.isSaved,
                          onTap: () => widget.onSave(widget.post),
                        ),
                      ],
                    ),
                  ),
                  _PostMeta(
                    post: widget.post,
                    pageIndex: _pageIndex,
                  ),
                  const SizedBox(height: 14),
                ],
              ),
              _HeartBurst(animation: _burstController),
            ],
          ),
        ),
      ),
    );
  }
}

class _PostHeader extends StatelessWidget {
  const _PostHeader({
    required this.post,
    required this.onProfileTap,
    required this.onMoreTap,
  });

  final Post post;
  final VoidCallback onProfileTap;
  final VoidCallback onMoreTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        children: [
          GestureDetector(
            onTap: onProfileTap,
            child: CircleAvatar(
              radius: 22,
              backgroundImage: NetworkImage(post.userAvatar),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: GestureDetector(
              onTap: onProfileTap,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(post.username,
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 2),
                  Text(post.location,
                      style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
          ),
          IconButton(
            onPressed: onMoreTap,
            icon: const Icon(Icons.more_horiz_rounded),
          ),
        ],
      ),
    );
  }
}

class _PostMeta extends StatelessWidget {
  const _PostMeta({required this.post, required this.pageIndex});

  final Post post;
  final int pageIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('${post.likes} likes',
                  style: Theme.of(context).textTheme.titleMedium),
              const Spacer(),
              Row(
                children: List.generate(post.images.length, (index) {
                  final active = index == pageIndex;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    height: 6,
                    width: active ? 18 : 6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      gradient: active
                          ? const LinearGradient(
                              colors: [
                                AppColors.pink,
                                AppColors.orange,
                              ],
                            )
                          : null,
                      color: active
                          ? null
                          : Theme.of(context)
                              .iconTheme
                              .color
                              ?.withOpacity(0.3),
                    ),
                  );
                }),
              ),
            ],
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyMedium,
              children: [
                TextSpan(
                  text: '${post.username} ',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                TextSpan(text: post.caption),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(post.timeAgo, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}

class _GlowingSaveButton extends StatelessWidget {
  const _GlowingSaveButton({required this.isSaved, required this.onTap});

  final bool isSaved;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: isSaved
              ? const LinearGradient(
                  colors: [AppColors.orange, AppColors.pink],
                )
              : null,
          boxShadow: isSaved
              ? [
                  BoxShadow(
                    color: AppColors.orange.withOpacity(0.5),
                    blurRadius: 20,
                    offset: const Offset(0, 6),
                  )
                ]
              : null,
        ),
        child: Icon(
          isSaved ? Icons.bookmark : Icons.bookmark_border,
          color: isSaved ? Colors.white : Theme.of(context).iconTheme.color,
        ),
      ),
    );
  }
}

class _HeartBurst extends StatelessWidget {
  const _HeartBurst({required this.animation});

  final AnimationController animation;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          final progress = Curves.easeOutExpo.transform(animation.value);
          return Opacity(
            opacity: (1 - progress).clamp(0, 1),
            child: Transform.scale(
              scale: 0.8 + progress * 1.6,
              child: child,
            ),
          );
        },
        child: Center(
          child: Icon(
            Icons.favorite,
            size: 110,
            color: AppColors.pink.withOpacity(0.6),
          ),
        ),
      ),
    );
  }
}

Future<void> _showPostOptions(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Theme.of(context).colorScheme.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _OptionTile(
              icon: Icons.bookmark_add_outlined,
              label: 'Save to collection',
              onTap: () => Navigator.of(context).pop(),
            ),
            _OptionTile(
              icon: Icons.link,
              label: 'Copy link',
              onTap: () => Navigator.of(context).pop(),
            ),
            _OptionTile(
              icon: Icons.report_gmailerrorred_outlined,
              label: 'Report',
              onTap: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    },
  );
}

class _OptionTile extends StatelessWidget {
  const _OptionTile({required this.icon, required this.label, required this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      onTap: onTap,
    );
  }
}
