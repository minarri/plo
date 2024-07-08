import 'package:algoliasearch/algoliasearch.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plo/repository/firebase_post_repository.dart';

import '../common/utils/log_util.dart';
import '../constants/algolia_constants.dart';
import '../model/post_model.dart';
import '../model/state_model/search_filter_options_model.dart';

class SearchService {
  SearchService({required this.ref});
  final Ref ref;
  final searchClient = SearchClient(
    apiKey: AlgoliaConstants.algoliaApiKey,
    appId: AlgoliaConstants.algoliaAppId,
  );

  Stream getSearchQuery(String? query) {
    if (query == null || query.isEmpty) {
      return const Stream.empty();
    }
    final index = searchClient
        .searchIndex(
          request: SearchForHits(
            indexName: AlgoliaConstants.sortByNewestIndexName,
            query: query,
            page: 0,
            hitsPerPage: 10,
          ),
        )
        .asStream();

    return index;
  }

  Future<List<PostModel>?> searchPost(FilterOptions filterOptions) async {
    try {
      if (filterOptions.searchQuery.isEmpty || filterOptions.searchQuery == ' ') {
        return null;
      }
      final queryHits = SearchForHits(
        indexName: filterOptions.sortOptions.sortByAlgoliaIndexName(),
        query: filterOptions.searchQuery,
        facetFilters: filterOptions.getCategoryList(),
      );
      final responseHits = await searchClient.searchIndex(request: queryHits);
      if (responseHits.hits.isEmpty) {
        return [];
      }
      List<String> uidList = [];
      for (var hit in responseHits.hits) {
        uidList.add(hit[PostModelFieldNameConstants.uploadUserUid]);
      }
      final List<PostModel>? posts = await ref
          .watch(firebasePostRepositoryProvider)
          .fetchMultiplePostsFromHitList(uidList);
      return posts;
    } catch (err) {
      logToConsole("Error in searchItem: $err");
      return null;
    }
  }
}

final searchServiceProvider = Provider.autoDispose<SearchService>((ref) {
  return SearchService(ref: ref);
});
