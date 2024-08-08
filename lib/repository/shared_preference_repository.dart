import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceRepository {
  /// Loads the search history from the shared preferences
  Future<List<String>?> loadSearchHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? searchHistoryResult = prefs.getStringList('searchHistory');
    return searchHistoryResult;
  }

  /// Takes a list of strings and saves it to the shared preferences
  Future<bool> saveSearchHistory(List<String> itemsToBeSave) async {
    print("Saving... ${itemsToBeSave}");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final result = await prefs.setStringList('searchHistory', itemsToBeSave);
    return result;
  }

  /// Adds a single item to the search history.
  /// Returns updated list if successful, null if not.
  Future<List<String>?> addSingleSearchHistoryItem(String itemToBeAdded) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? searchHistoryResult = prefs.getStringList('searchHistory');
    print("searchHistoryResult: ${searchHistoryResult}");
    if (searchHistoryResult != null) {
      // If it's more than 10 items, remove the last item
      if (searchHistoryResult.length >= 10) {
        searchHistoryResult.removeAt(0);
      }
      if (searchHistoryResult.contains(itemToBeAdded)) {
        searchHistoryResult.remove(itemToBeAdded);
      }
      searchHistoryResult.add(itemToBeAdded);
      final result =
          await prefs.setStringList('searchHistory', searchHistoryResult);
      return searchHistoryResult;
    } else {
      searchHistoryResult = [itemToBeAdded];
      final result =
          await prefs.setStringList('searchHistory', searchHistoryResult);
      return searchHistoryResult;
    }
  }

  /// Deletes the search history from the shared preferences
  Future<bool> deleteEntireSearchHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final result = await prefs.remove('searchHistory');
    return result;
  }

  /// Deletes a single item from the search history
  Future<bool> deleteSingleSearchHistoryItem(String itemToBeDeleted) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? searchHistoryResult = prefs.getStringList('searchHistory');
    if (searchHistoryResult != null) {
      searchHistoryResult.remove(itemToBeDeleted);
      final result =
          await prefs.setStringList('searchHistory', searchHistoryResult);
      return result;
    } else {
      return false;
    }
  }

  // User first time opening the app or not
  Future<bool> isUserFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isUserFirstTime = prefs.getBool('isUserFirstTime');
    return isUserFirstTime ?? true;
  }

  Future<bool> setUserFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final result = await prefs.setBool('isUserFirstTime', false);
    return result;
  }
}

final sharedPreferenceRepositoryProvider =
    Provider<SharedPreferenceRepository>((ref) {
  return SharedPreferenceRepository();
});
