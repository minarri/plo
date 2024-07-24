import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/utils/log_util.dart';
import '../../model/post_model.dart';
import '../../services/search_service.dart';
import 'filter_options_controller.dart';

class SearchPostsController extends StateNotifier<List<PostModel>?> {
  final Ref ref;
  String searchQuery = "";

  SearchPostsController(this.ref) : super(null) {
    _init();
  }

  // Initialization method
  Future<void> _init() async {
    // Set the initial state if needed
    state = [];
    logToConsole("SearchPostsController: Initialized");
  }

  Future<void> setSearchQuery(String query) async {
    searchQuery = query;
    final filterOptions = ref.read(filterOptionsControllerProvider);
    ref.read(filterOptionsControllerProvider.notifier).state = filterOptions;

    logToConsole("SearchPostsController: Search query updated to $query");
    logToConsole("SearchPostsController: Filter options updated to $filterOptions");

    final posts = await ref.read(searchServiceProvider).searchPost(filterOptions);
    state = posts;

    logToConsole("SearchPostsController: Fetched ${posts?.length ?? 0} posts");
  }
}

final searchPostsControllerProvider = StateNotifierProvider.autoDispose<SearchPostsController, List<PostModel>?>((ref) {
  ref.onDispose(() {
    logToConsole("SearchPostsController disposed");
  });
  return SearchPostsController(ref);
});
