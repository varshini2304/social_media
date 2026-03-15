import 'package:flutter/material.dart';

import '../models/post_model.dart';

class PostDetailScreen extends StatelessWidget {
  const PostDetailScreen({
    super.key,
    required this.post,
    required this.initialIndex,
  });

  final Post post;
  final int initialIndex;

  @override
  Widget build(BuildContext context) {
    final controller = PageController(initialPage: initialIndex);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: PageView.builder(
        controller: controller,
        itemCount: post.images.length,
        itemBuilder: (context, index) {
          final imageUrl = post.images[index];
          return Hero(
            tag: '${post.id}-$index',
            child: InteractiveViewer(
              minScale: 0.8,
              maxScale: 4,
              child: Image.network(imageUrl, fit: BoxFit.contain),
            ),
          );
        },
      ),
    );
  }
}
