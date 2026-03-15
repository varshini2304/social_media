import 'package:flutter/material.dart';

import '../utils/constants.dart';

class ShimmerPost extends StatelessWidget {
  const ShimmerPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(26),
        child: Container(
          color: Theme.of(context).colorScheme.surface,
          child: const Column(
            children: [
              SizedBox(height: 16),
              ShimmerBar(widthFactor: 0.6, height: 12),
              SizedBox(height: 14),
              ShimmerBox(height: 280),
              SizedBox(height: 16),
              ShimmerBar(widthFactor: 0.4, height: 10),
              SizedBox(height: 12),
              ShimmerBar(widthFactor: 0.8, height: 10),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class ImageShimmer extends StatelessWidget {
  const ImageShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const ShimmerBox(height: double.infinity);
  }
}

class ShimmerBox extends StatefulWidget {
  const ShimmerBox({super.key, required this.height});

  final double height;

  @override
  State<ShimmerBox> createState() => _ShimmerBoxState();
}

class _ShimmerBoxState extends State<ShimmerBox>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(-1 + _controller.value * 2, -0.3),
                end: Alignment(1 + _controller.value * 2, 0.3),
                colors: const [
                  AppColors.shimmerBase,
                  AppColors.shimmerHighlight,
                  AppColors.shimmerBase,
                ],
              ),
              borderRadius: BorderRadius.circular(18),
            ),
          );
        },
      ),
    );
  }
}

class ShimmerBar extends StatelessWidget {
  const ShimmerBar({super.key, required this.widthFactor, required this.height});

  final double widthFactor;
  final double height;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: widthFactor,
      child: ShimmerBox(height: height),
    );
  }
}
