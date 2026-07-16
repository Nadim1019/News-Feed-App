import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../change_notifiers/feed_notifier.dart';

class FeedScreen extends StatefulWidget {
  final FeedNotifier notifier;

  const FeedScreen({super.key, required this.notifier});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  void initState() {
    super.initState();
    widget.notifier.loadPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('News Feed')),
      body: ListenableBuilder(
        listenable: widget.notifier,
        builder: (context, _) {
          if (widget.notifier.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (widget.notifier.errorMessage != null) {
            return Center(child: Text(widget.notifier.errorMessage!));
          }

          return ListView.builder(
            itemCount: widget.notifier.posts.length,
            itemBuilder: (context, index) {
              final post = widget.notifier.posts[index];
              return ListTile(
                title: Text(post.title, maxLines: 1, overflow: TextOverflow.ellipsis),
                subtitle: Text(post.body, maxLines: 2, overflow: TextOverflow.ellipsis),
                onTap: () {
                  context.push(
                    '/post/${post.id}',
                    extra: {'title': post.title, 'body': post.body},
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              final titleController = TextEditingController();
              final bodyController = TextEditingController();

              return AlertDialog(
                title: const Text('Create New Post'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(controller: titleController, decoration: const InputDecoration(labelText: 'Title')),
                    TextField(controller: bodyController, decoration: const InputDecoration(labelText: 'Body')),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      widget.notifier.addPost(titleController.text, bodyController.text);
                      context.pop(); // go_router way to close the dialog
                    },
                    child: const Text('Post'),
                  )
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}