import 'dart:ui';

import 'package:flutter/material.dart';

import '../models/post_model.dart';
import '../screens/post_detail_screen.dart';
import '../utils/constants.dart';
import 'shimmer_post.dart';

class CarouselWidget extends StatefulWidget {
  const CarouselWidget({
    super.key,
    required this.post,
    required this.onPageChanged,
    required this.onDoubleTap,
  });

  final Post post;
  final ValueChanged<int> onPageChanged;
  final VoidCallback onDoubleTap;

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      child: PageView.builder(
        controller: _pageController,
        physics: const BouncingScrollPhysics(),
        itemCount: widget.post.images.length,
        onPageChanged: widget.onPageChanged,
        itemBuilder: (context, index) {
          final imageUrl = widget.post.images[index];
          return AnimatedBuilder(
            animation: _pageController,
            builder: (context, child) {
              double value = 1.0;
              if (_pageController.position.haveDimensions) {
                value = _pageController.page! - index;
                value = (1 - (value.abs() * 0.08)).clamp(0.92, 1.0);
              }
              return Transform.scale(
                scale: value,
                child: child,
              );
            },
            child: GestureDetector(
              onDoubleTap: widget.onDoubleTap,
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => PostDetailScreen(
                    post: widget.post,
                    initialIndex: index,
                  ),
                ),
              ),
              child: Hero(
                tag: '${widget.post.id}-$index',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(22),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, progress) {
                          if (progress == null) return child;
                          return const ImageShimmer();
                        },
                      ),
                      Positioned(
                        left: 18,
                        top: 18,
                        child: _GlassPill(
                          label: '${index + 1}/${widget.post.images.length}',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _GlassPill extends StatelessWidget {
  const _GlassPill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: isDark ? Colors.white10 : Colors.white70,
            border: Border.all(color: Colors.white30),
          ),
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ),
    );
  }
}
