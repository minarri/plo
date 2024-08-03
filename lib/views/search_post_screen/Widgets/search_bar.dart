import 'package:flutter/material.dart';
import 'package:plo/views/search_post_screen/Screens/search_post.dart';

class CustomSearchBar extends StatelessWidget {
  final String searchQuery;
  const CustomSearchBar({super.key, required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    var searchQueryController;
    return Hero(
      tag: "search",
      child: SearchBar(
        hintText: searchQuery,
        controller: searchQueryController,
        leading: const Icon(Icons.search),
        trailing: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: searchQueryController.clear,
          ),
        ],
        onSubmitted: (_) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const SearchPostsHero(),
            ),
          );
        },
      ),
    );
  }
}
