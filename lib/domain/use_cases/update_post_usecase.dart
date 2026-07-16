import '../entities/post.dart';
import '../repositories/post_repository.dart';

class UpdatePostUseCase {
  final PostRepository repository;

  UpdatePostUseCase(this.repository);

  Future<Post> call(int id, Post post) async {
    return await repository.updatePost(id, post);
  }
}