import 'package:flutter/foundation.dart';

import '../models/post_model.dart';
import '../repositories/post_repository.dart';

class FeedProvider extends ChangeNotifier {
  FeedProvider({PostRepository? repository}) : _repository = repository ?? PostRepository();

  final PostRepository _repository;
  final List<Post> _posts = [];
  bool _isLoading = true;
  bool _isLoadingMore = false;

  List<Post> get posts => List.unmodifiable(_posts);
  bool get isLoading => _isLoading;
  bool get isLoadingMore => _isLoadingMore;

  Future<void> loadInitial() async {
    if (!_isLoading) return;
    _posts.clear();
    _isLoading = true;
    notifyListeners();
    final data = await _repository.fetchInitialPosts();
    _posts.addAll(data);
    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadMore() async {
    if (_isLoadingMore) return;
    _isLoadingMore = true;
    notifyListeners();
    final data = await _repository.fetchMorePosts();
    _posts.addAll(data);
    _isLoadingMore = false;
    notifyListeners();
  }

  void toggleLike(Post post) {
    final index = _posts.indexOf(post);
    if (index == -1) return;
    final updated = post.copyWith(
      isLiked: !post.isLiked,
      likes: post.likes + (post.isLiked ? -1 : 1),
    );
    _posts[index] = updated;
    notifyListeners();
  }

  void toggleSave(Post post) {
    final index = _posts.indexOf(post);
    if (index == -1) return;
    _posts[index] = post.copyWith(isSaved: !post.isSaved);
    notifyListeners();
  }
}
