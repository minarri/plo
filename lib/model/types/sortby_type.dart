import '../../constants/algolia_constants.dart';

enum SortbyType {
  newest,
  views,
  likes;

  @override
  String toString() {
    switch (this) {
      case SortbyType.newest:
        return 'Newest';
      case SortbyType.views:
        return 'Views';
      case SortbyType.likes:
        return 'Likes';
      default:
        return 'Newest';
    }
  }

  static SortbyType stringToSortybyType(String? string) {
    switch (string) {
      case 'Newest':
        return SortbyType.newest;
      case 'Views':
        return SortbyType.views;
      case 'Likes':
        return SortbyType.likes;
      default:
        return SortbyType.newest;
    }
  }

  String sortByAlgoliaIndexName() {
    switch (this) {
      case SortbyType.newest:
        return AlgoliaConstants.sortByNewestIndexName;
      case SortbyType.views:
        return AlgoliaConstants.sortByViewsIndexName;
      case SortbyType.likes:
        return AlgoliaConstants.sortByLikesIndexName;
      default:
        return AlgoliaConstants.sortByNewestIndexName;
    }
  }
}
