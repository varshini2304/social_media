import 'dart:math';

import '../models/post_model.dart';
import '../services/api_service.dart';

class PostRepository {
  PostRepository({ApiService? apiService}) : _apiService = apiService ?? const ApiService();

  final ApiService _apiService;
  final Random _random = Random();

  Future<List<Post>> fetchInitialPosts() async {
    await _apiService.simulateLatency(const Duration(milliseconds: 1200));
    return _seedPosts;
  }

  Future<List<Post>> fetchMorePosts() async {
    await _apiService.simulateLatency();
    return List.generate(2, (_) => Post.random(_random));
  }

  static final List<Post> _seedPosts = [
    Post(
      id: 'post-1',
      username: 'luna.ray',
      userAvatar: 'https://i.pravatar.cc/150?img=10',
      location: 'Santorini, Greece',
      caption: 'Soft light and quiet waves in the Aegean.',
      images: [
        'https://picsum.photos/seed/a1/900/1200',
        'https://picsum.photos/seed/a2/900/1200',
      ],
      timeAgo: '2h ago',
      likes: 1482,
    ),
    Post(
      id: 'post-2',
      username: 'theo.design',
      userAvatar: 'https://i.pravatar.cc/150?img=12',
      location: 'Copenhagen, Denmark',
      caption: 'Minimal forms, maximum mood.',
      images: [
        'https://picsum.photos/seed/b1/900/1200',
        'https://picsum.photos/seed/b2/900/1200',
        'https://picsum.photos/seed/b3/900/1200',
      ],
      timeAgo: '5h ago',
      likes: 2024,
    ),
    Post(
      id: 'post-3',
      username: 'ariel.stories',
      userAvatar: 'https://i.pravatar.cc/150?img=14',
      location: 'Kyoto, Japan',
      caption: 'Temple mornings and matcha haze.',
      images: [
        'https://picsum.photos/seed/c1/900/1200',
        'https://picsum.photos/seed/c2/900/1200',
      ],
      timeAgo: '8h ago',
      likes: 980,
    ),
    Post(
      id: 'post-4',
      username: 'nova.films',
      userAvatar: 'https://i.pravatar.cc/150?img=16',
      location: 'Lisbon, Portugal',
      caption: 'Golden hour streets with pastel shadows.',
      images: [
        'https://picsum.photos/seed/d1/900/1200',
      ],
      timeAgo: '12h ago',
      likes: 734,
    ),
    Post(
      id: 'post-5',
      username: 'studio.aurora',
      userAvatar: 'https://i.pravatar.cc/150?img=18',
      location: 'Oslo, Norway',
      caption: 'Nordic calm with neon accents.',
      images: [
        'https://picsum.photos/seed/e1/900/1200',
        'https://picsum.photos/seed/e2/900/1200',
      ],
      timeAgo: '1d ago',
      likes: 421,
    ),
  ];
}
