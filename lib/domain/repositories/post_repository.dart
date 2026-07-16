import '../entities/post.dart';

abstract class PostRepository {
  Future<List<Post>> getPosts();
  Future<Post> createPost(Post post); // POST
  Future<Post> updatePost(int id, Post post); // PUT
  Future<Post> patchPost(int id, Map<String, dynamic> data); // PATCH
}