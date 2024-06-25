import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plo/views/search_posts_screen/search_posts_controller.dart';

class SearchPostsMain extends ConsumerStatefulWidget {
  const SearchPostsMain({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SearchPostsMainState();
}

class _SearchPostsMainState extends ConsumerState<SearchPostsMain> {
  bool isFieldEmpty = false;
  List<String> searchHistory = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    final state = ref.watch(searchPostsControllerProvider);
    return Scaffold(

    );
  }
}
