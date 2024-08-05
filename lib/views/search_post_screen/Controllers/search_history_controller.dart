import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchHistoryController extends StateNotifier<List<String>> {
  SearchHistoryController() : super([]);

  List<String> get getList => state;

  void setList(List<String> newList) {
    newList = newList.reversed.toList();
    state = newList;
  }

  void removeEntireList() {
    state = [];
  }

  void removeSingleItem(String itemToBeDeleted) {
    state.remove(itemToBeDeleted);
  }

  void addSingleItem(String itemToBeAdded) {
    state.add(itemToBeAdded);
  }

  void removeLastItem() {
    state.removeLast();
  }
}

final searchHistoryProvider = StateNotifierProvider.autoDispose<SearchHistoryController, List<String>>((ref) {
  ref.onDispose(() {
    log('SearchHistoryListProvider disposed');
  });
  return SearchHistoryController();
});
