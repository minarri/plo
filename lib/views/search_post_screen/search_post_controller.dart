import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/utils/log_util.dart';

class SearchPostsController extends StateNotifier<AsyncValue<void>> {
  final Ref ref;
  String searchQuery = "";

  SearchPostsController(this.ref) : super(const AsyncLoading()) {
    _init();
  }

  _init() async {
    state = const AsyncLoading();
    // final searchHistory = await ref.watch(sharedPreferenceRepositoryProvider).loadSearchHistory();
    // if (searchHistory != null) ref.read(searchHistoryListProvider.notifier).setList(searchHistory);
    state = const AsyncData(null);
  }

  void setSearchQuery(String newSearchQuery) {
    searchQuery = newSearchQuery;
  }
}

final searchPostsControllerProvider = StateNotifierProvider.autoDispose<SearchPostsController, AsyncValue<void>>((ref) {
  ref.onDispose(() {
    logToConsole("SearchPostsController disposed");
  });
  return SearchPostsController(ref);
});
