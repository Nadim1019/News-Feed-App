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
}