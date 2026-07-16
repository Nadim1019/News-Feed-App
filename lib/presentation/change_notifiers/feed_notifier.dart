import 'package:flutter/material.dart';
import '../../domain/entities/post.dart';
import '../../domain/use_cases/get_posts_usecase.dart';
import '../../domain/use_cases/create_post_usecase.dart';

class FeedNotifier extends ChangeNotifier {
  final GetPostsUseCase getPostsUseCase;
  final CreatePostUseCase createPostUseCase;

  FeedNotifier(this.getPostsUseCase, this.createPostUseCase);

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

  Future<void> addPost(String title, String body) async {
    try {
      final newPost = Post(id: 101, title: title, body: body);
      final created = await createPostUseCase(newPost);

      _posts.insert(0, created);
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }
}