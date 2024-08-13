import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Controllers/search_post_controller.dart';
import 'search_post_result.dart';

class SearchPostsHero extends ConsumerStatefulWidget {
  const SearchPostsHero({super.key});

  @override
  _SearchPostsHeroState createState() => _SearchPostsHeroState();
}

class _SearchPostsHeroState extends ConsumerState<SearchPostsHero> {
  bool isFieldEmpty = false;
  List<String> searchHistory = [];
  final String searchHeroTag = "search";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController searchQuery = TextEditingController();
    // final state = ref.watch(searchPostsProvider);
    log("Search build was called");
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Hero(
                transitionOnUserGestures: true,
                tag: searchHeroTag,
                child: SearchBar(
                  controller: searchQuery,
                  leading: const Icon(Icons.search),
                  trailing: [
                    IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: searchQuery.clear,
                    ),
                  ],
                  hintText: "검색어를 입력해주세요",
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  onSubmitted: (_) async {
                    if (searchQuery.text.isEmpty || searchQuery.text == " ") {
                      setState(() {
                        isFieldEmpty = true;
                      });
                      return;
                    }
                    ref.watch(searchPostsProvider.notifier).saveSearchQuery(searchQuery.text);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => SearchPostResult(searchHeroTag: searchHeroTag, searchQuery: searchQuery.text),
                    ));
                  },
                  autoFocus: true,
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Recent search",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  TextButton(
                    onPressed: () {
                      ref.watch(searchPostsProvider.notifier).deleteEntireSearchHistory();
                    },
                    child: const Text(
                      "Delete all",
                      style: TextStyle(color: Colors.grey, fontSize: 17),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
