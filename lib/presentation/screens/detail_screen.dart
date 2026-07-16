import 'package:flutter/material.dart';
import '../../domain/entities/post.dart';
import '../../domain/use_cases/update_post_usecase.dart';
import '../../domain/use_cases/patch_post_usecase.dart';

class DetailScreen extends StatefulWidget {
  final int postId;
  final String initialTitle;
  final String initialBody;
  final UpdatePostUseCase updatePostUseCase;
  final PatchPostUseCase patchPostUseCase;

  const DetailScreen({
    super.key,
    required this.postId,
    required this.initialTitle,
    required this.initialBody,
    required this.updatePostUseCase,
    required this.patchPostUseCase,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late String title;
  late String body;

  @override
  void initState() {
    super.initState();
    title = widget.initialTitle;
    body = widget.initialBody;
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Post #${widget.postId}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Text(body, style: const TextStyle(fontSize: 16, height: 1.5)),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () async {
                try {
                  final updated = await widget.updatePostUseCase(
                    widget.postId,
                    Post(id: widget.postId, title: 'Updated Title (PUT)', body: 'Updated Body (PUT)'),
                  );
                  setState(() {
                    title = updated.title;
                    body = updated.body;
                  });
                  showMessage('PUT Success!');
                } catch (e) {
                  showMessage('Failed to PUT: $e');
                }
              },
              child: const Text('Test PUT (Replace All)'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                try {
                  final patched = await widget.patchPostUseCase(
                    widget.postId,
                    {'title': 'Patched Title Only (PATCH)'},
                  );
                  setState(() {
                    title = patched.title;
                  });
                  showMessage('PATCH Success!');
                } catch (e) {
                  showMessage('Failed to PATCH: $e');
                }
              },
              child: const Text('Test PATCH (Update Title)'),
            ),
          ],
        ),
      ),
    );
  }
}