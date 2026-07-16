import 'package:dio/dio.dart';
import '../models/post_model.dart';

class PostRemoteDataSource {
  final Dio dio;

  PostRemoteDataSource(this.dio);

  Future<List<PostModel>> getPosts() async {
    try {
      final response = await dio.get('https://jsonplaceholder.typicode.com/posts');
      final List<dynamic> data = response.data;
      return data.map((json) => PostModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load posts from server: $e');
    }
  }
  // POST: Create a new post
  Future<PostModel> createPost(PostModel post) async {
    final response = await dio.post('https://jsonplaceholder.typicode.com/posts', data: post.toJson());
    return PostModel.fromJson(response.data);
  }

// PUT: Replace an entire existing post
  Future<PostModel> updatePost(int id, PostModel post) async {
    final response = await dio.put('https://jsonplaceholder.typicode.com/posts/$id', data: post.toJson());
    return PostModel.fromJson(response.data);
  }

// PATCH: Update only specific parts of a post
  Future<PostModel> patchPost(int id, Map<String, dynamic> data) async {
    final response = await dio.patch('https://jsonplaceholder.typicode.com/posts/$id', data: data);
    return PostModel.fromJson(response.data);
  }
}