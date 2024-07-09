import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plo/common/utils/log_util.dart';

class SearchPostsController extends StateNotifier<AsyncValue<void>> {
  Ref ref;
  String searchQuery = "";
  SearchPostsController(this.ref) : super(const AsyncLoading()) {
    _init();
  }

  _init() async {
    // state = const AsyncLoading();
    state = const AsyncData(null);
  }

  void setSearchQuery(String query) {
    searchQuery = query;
  }
}

final searchPostsControllerProvider = StateNotifierProvider.autoDispose<SearchPostsController, AsyncValue<void>> ((ref) {
  ref.onDispose(() {
    logToConsole("SearchPostsController disposed");
  });
  return SearchPostsController(ref);
});
