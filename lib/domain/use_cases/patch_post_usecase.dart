import '../entities/post.dart';
import '../repositories/post_repository.dart';

class PatchPostUseCase {
  final PostRepository repository;

  PatchPostUseCase(this.repository);

  Future<Post> call(int id, Map<String, dynamic> data) async {
    return await repository.patchPost(id, data);
  }
}