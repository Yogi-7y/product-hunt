import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_hunt/screens/home/models/post_model.dart';
import 'package:product_hunt/screens/home/providers/post_provider.dart';
import 'package:product_hunt/shared/post_tile.dart';

class PostSearchDelegate extends SearchDelegate<PostModel?> {
  final List<PostModel> posts;

  PostSearchDelegate(this.posts);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(icon: const Icon(Icons.clear), onPressed: () => query = ''),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<PostModel> _suggestions = posts
        .where(
          (element) =>
              element.name.toLowerCase().contains(query) ||
              element.tagline.toLowerCase().contains(query),
        )
        .toList();

    return ListView.builder(
      itemCount: _suggestions.length,
      itemBuilder: (BuildContext context, int index) {
        return ProviderScope(
          overrides: [
            postProvider.overrideWithValue(_suggestions[index]),
          ],
          child: const PostTile(),
        );
      },
    );
  }

  @override
  String get query => super.query.toLowerCase();

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<PostModel> _suggestions = posts
        .where(
          (element) =>
              element.name.toLowerCase().contains(query) ||
              element.tagline.toLowerCase().contains(query),
        )
        .toList();

    return ListView.builder(
      itemCount: _suggestions.length,
      itemBuilder: (BuildContext context, int index) {
        return ProviderScope(
          overrides: [
            postProvider.overrideWithValue(_suggestions[index]),
          ],
          child: const PostTile(),
        );
      },
    );
  }
}
