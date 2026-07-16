import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import '../data/data_sources/post_remote_data_source.dart';
import '../data/repositories/post_repository_impl.dart';
import '../domain/use_cases/get_posts_usecase.dart';
import '../domain/use_cases/create_post_usecase.dart';
import '../domain/use_cases/update_post_usecase.dart';
import '../domain/use_cases/patch_post_usecase.dart';
import '../presentation/change_notifiers/feed_notifier.dart';
import '../presentation/screens/feed_screen.dart';
import '../presentation/screens/detail_screen.dart';

final Dio dio = Dio();
final PostRemoteDataSource dataSource = PostRemoteDataSource(dio);
final PostRepositoryImpl repository = PostRepositoryImpl(dataSource);
final GetPostsUseCase getPostsUseCase = GetPostsUseCase(repository);
final CreatePostUseCase createPostUseCase = CreatePostUseCase(repository);
final UpdatePostUseCase updatePostUseCase = UpdatePostUseCase(repository);
final PatchPostUseCase patchPostUseCase = PatchPostUseCase(repository);

final FeedNotifier feedNotifier = FeedNotifier(getPostsUseCase, createPostUseCase);

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => FeedScreen(notifier: feedNotifier),
    ),
    GoRoute(
      path: '/post/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        final extra = state.extra as Map<String, dynamic>?;
        return DetailScreen(
          postId: int.parse(id),
          initialTitle: extra?['title'] ?? '',
          initialBody: extra?['body'] ?? '',
          updatePostUseCase: updatePostUseCase,
          patchPostUseCase: patchPostUseCase,
        );
      },
    ),
  ],
);