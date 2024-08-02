import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/utils/log_util.dart';
import '../../common/widgets/post_list_widget.dart';
import '../../model/post_model.dart';
import '../../model/state_model/search_filter_options_model.dart';
import '../../services/search_service.dart';
import 'filter_options_controller.dart';

class SearchPostsMain extends ConsumerStatefulWidget {
  const SearchPostsMain({super.key});

  @override
  _SearchPostsMainState createState() => _SearchPostsMainState();
}

class _SearchPostsMainState extends ConsumerState<SearchPostsMain> {
  bool isFieldEmpty = false;
  List<String> searchHistory = [];
  TextEditingController searchQueryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.watch(filterOptionsControllerProvider.notifier).setSearchQuery(searchQueryController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    final filterOptions = ref.watch(filterOptionsControllerProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SearchBar(
                controller: searchQueryController,
                leading: const Icon(Icons.search),
                trailing: [
                  IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: searchQueryController.clear,
                  ),
                ],
                hintText: "검색어를 입력해주세요",
                onSubmitted: (_) async {
                  if (searchQueryController.text.isEmpty) {
                    logToConsole("searchQuery is empty");
                    setState(() {
                      isFieldEmpty = true;
                    });
                    return;
                  }
                  setState(() {
                    ref.watch(filterOptionsControllerProvider.notifier).setSearchQuery(searchQueryController.text);
                  });
                  logToConsole("Search query submitted: ${searchQueryController.text}");
                  Expanded(
                    child: PostResultWidget(
                      filterOptions: filterOptions,
                    ),
                  );
                },
                // onTapOutside: (event) => FocusScope.of(context).unfocus(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PostResultWidget extends ConsumerWidget {
  final FilterOptions filterOptions;
  const PostResultWidget({super.key, required this.filterOptions});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    logToConsole("PostResultWidget build called");
    return Container(
      child: ref.watch(searchPostsFutureProvider(filterOptions)).when(
        loading: () {
          logToConsole("Hit loading");
          return const Center(child: CircularProgressIndicator());
        },
        error: (error, stackTrace) {
          logToConsole('Error occurred: $error');
          return const Center(child: Text("Unknown error occurred"));
        },
        data: (searchedPosts) {
          if (searchedPosts == null) {
            logToConsole('No posts found');
            return const Center(child: Text('No posts found'));
          }
          logToConsole('Posts found: ${searchedPosts.length}');
          return PostListWidget(
              posts: searchedPosts,
              refreshFunction: () {
                ref.refresh(searchPostsFutureProvider(filterOptions));
              });
        },
      ),
    );
  }
}

final searchPostsFutureProvider = FutureProvider.family.autoDispose<List<PostModel>?, FilterOptions>((ref, filterOptions) async {
  final posts = await ref.watch(searchServiceProvider).searchPost(filterOptions);
  return posts;
});
