import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plo/views/search_post_screen/filter_options_controller.dart';

import '../../../common/utils/log_util.dart';
import '../../../common/widgets/post_list_widget.dart';
import '../../../model/post_model.dart';
import '../../../model/state_model/search_filter_options_model.dart';
import '../../../services/search_service.dart';

class PostResultWidget extends ConsumerStatefulWidget {
  final FilterOptions filterOptions;
  final String searchQuery;
  const PostResultWidget({super.key, required this.filterOptions, required this.searchQuery});

  @override
  ConsumerState<PostResultWidget> createState() => _PostResultWidgetState();
}

class _PostResultWidgetState extends ConsumerState<PostResultWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      logToConsole("PostResultWidget initState called with searchQuery: ${widget.searchQuery}");
      ref.watch(filterOptionsControllerProvider.notifier).setSearchQuery(widget.searchQuery);
    });
  }

  @override
  Widget build(BuildContext context) {
    logToConsole("PostResultWidget build called with searchQuery: ${widget.searchQuery}");
    return Container(
      child: ref.watch(searchPostsFutureProvider(widget.filterOptions)).when(
            data: (searchedPosts) {
              if (searchedPosts == null) {
                logToConsole('No posts found');
                return Center(child: Text('No posts found'));
              }
              logToConsole('Posts found: ${searchedPosts.length}');
              return PostListWidget(
                  posts: searchedPosts,
                  refreshFunction: () {
                    ref.refresh(searchPostsFutureProvider(widget.filterOptions));
                  });
            },
            error: (error, stackTrace) {
              logToConsole('Error occurred: $error');
              return Center(child: Text("Unknown error occurred"));
            },
            loading: () => const SizedBox(
                child: Center(
              child: CircularProgressIndicator(),
            )),
          ),
    );
  }
}

final searchPostsFutureProvider = FutureProvider.family.autoDispose<List<PostModel>?, FilterOptions>((ref, filterOptions) async {
  final posts = await ref.watch(searchServiceProvider).searchPost(filterOptions);
  return posts;
});
