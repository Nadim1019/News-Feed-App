import 'package:flutter/material.dart';
import '../../domain/entities/post.dart';
import '../../domain/use_cases/get_posts_usecase.dart';

class FeedNotifier extends ChangeNotifier {
  final GetPostsUseCase getPostsUseCase;

  FeedNotifier(this.getPostsUseCase);

  List<Post> _posts = [];
  List<Post> get posts => _posts;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> loadPosts() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _posts = await getPostsUseCase();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}