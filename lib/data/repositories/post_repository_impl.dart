import '../../domain/entities/post.dart';
import '../../domain/repositories/post_repository.dart';
import '../data_sources/post_remote_data_source.dart';
import '../models/post_model.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource remoteDataSource;

  PostRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Post>> getPosts() async {
    return await remoteDataSource.getPosts();
  }

  @override
  Future<Post> createPost(Post post) async {
    final postModel = PostModel(id: post.id, title: post.title, body: post.body);
    return await remoteDataSource.createPost(postModel);
  }

  @override
  Future<Post> updatePost(int id, Post post) async {
    final postModel = PostModel(id: post.id, title: post.title, body: post.body);
    return await remoteDataSource.updatePost(id, postModel);
  }

  @override
  Future<Post> patchPost(int id, Map<String, dynamic> data) async {
    return await remoteDataSource.patchPost(id, data);
  }
}