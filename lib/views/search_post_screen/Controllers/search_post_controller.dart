import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/utils/log_util.dart';
import '../../../repository/shared_preference_repository.dart';
import 'search_history_controller.dart';

class SearchPostsController extends StateNotifier<AsyncValue<void>> {
  final Ref ref;
  String searchQuery = "";
  SearchPostsController(this.ref) : super(const AsyncLoading()) {
    _init();
  }
  _init() async {
    state = const AsyncLoading();
    final searchHistory = await ref.watch(sharedPreferenceRepositoryProvider).loadSearchHistory();
    if (searchHistory != null) ref.read(searchHistoryProvider.notifier).setList(searchHistory);
    state = const AsyncData(null);
  }

  void setSearchQuery(String newSearchQuery) {
    searchQuery = newSearchQuery;
  }

  bool _checkListOver10() {
    final List<String> updatedList = ref.read(searchHistoryProvider.notifier).getList;
    if (updatedList.length >= 10) {
      return true;
    } else {
      return false;
    }
  }

  void saveSearchQuery(String searchQuery) async {
    state = const AsyncLoading();

    final List<String>? result = await ref.watch(sharedPreferenceRepositoryProvider).addSingleSearchHistoryItem(searchQuery);
    if (result != null) {
      ref.read(searchHistoryProvider.notifier).setList(result);
    } else {
      logToConsole("Error saving search query");
    }
    state = const AsyncData(null);
  }

  void deleteSingleItemInSearchHistroy(String searchQuery) {
    state = const AsyncLoading();
    ref.read(searchHistoryProvider.notifier).removeSingleItem(searchQuery);
    final List<String> updatedList = ref.read(searchHistoryProvider.notifier).getList;
    ref.watch(sharedPreferenceRepositoryProvider).saveSearchHistory(updatedList);
    state = const AsyncData(null);
  }

  void deleteEntireSearchHistory() {
    state = const AsyncLoading();
    ref.read(searchHistoryProvider.notifier).removeEntireList();
    ref.watch(sharedPreferenceRepositoryProvider).saveSearchHistory([]);
    state = const AsyncData(null);
  }
}

final searchPostsProvider = StateNotifierProvider.autoDispose<SearchPostsController, AsyncValue<void>>((ref) {
  ref.onDispose(() {
    logToConsole("SearchPostsController disposed");
  });
  return SearchPostsController(ref);
});
