import 'package:flutter/material.dart';
import 'package:movie_matcher/models/movie.dart';

class ConfirmDelete extends StatelessWidget {
  final Movie movie;
  final VoidCallback onDelete;

  const ConfirmDelete({
    super.key,
    required this.movie,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Confirm deletion"),
      content: Text("Are you sure you want to delete '${movie.originalTitle}' from your favorites?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            onDelete();
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("${movie.originalTitle} has been deleted from favorites!"),
                duration: const Duration(seconds: 2),
              ),
            );
          },
          child: const Text("Delete"),
        ),
      ],
    );
  }
}
