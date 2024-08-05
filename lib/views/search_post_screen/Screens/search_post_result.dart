import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/post_model.dart';
import '../../../model/state_model/search_filter_options_model.dart';
import '../../../services/search_service.dart';
import '../Controllers/filter_options_controller.dart';
import '../Widgets/search_bar.dart';

final searchItemFutureProvider = FutureProvider.family.autoDispose<List<PostModel>?, FilterOptions>((ref, filterOptions) async {
  final items = await ref.watch(searchServiceProvider).searchPost(filterOptions);
  return items;
});

class SearchPostResult extends ConsumerStatefulWidget {
  final String searchHeroTag;
  final String searchQuery;
  const SearchPostResult({super.key, required this.searchHeroTag, required this.searchQuery});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchPostResultState();
}

class _SearchPostResultState extends ConsumerState<SearchPostResult> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.watch(filterOptionsProvider.notifier).setSearchQuery(widget.searchQuery);
    });
  }

  @override
  Widget build(BuildContext context) {
    // final filterOptions = ref.watch(filterOptionsProvider);
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              CustomSearchBar(searchQuery: widget.searchQuery),
              // filter selection widget
            ],
          ),
        ),
      ),
    );
  }
}
