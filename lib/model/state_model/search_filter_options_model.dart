import '../post_model.dart';
import '../types/category_type.dart';
import '../types/sortby_type.dart';

class FilterOptions {
  String searchQuery;
  Set<CategoryType> categorySelected;
  SortbyType sortOptions;

  FilterOptions({
    this.searchQuery = "",
    this.categorySelected = const {
      CategoryType.general,
      CategoryType.information,
    },
    this.sortOptions = SortbyType.newest,
  });

  FilterOptions update({
    String? searchQuery,
    Set<CategoryType>? categorySelected,
    SortbyType? sortOptions,
  }) {
    return FilterOptions(
      searchQuery: searchQuery ?? this.searchQuery,
      categorySelected: categorySelected ?? this.categorySelected,
      sortOptions: sortOptions ?? this.sortOptions,
    );
  }

  List<String> getCategoryList() {
    List<String> categoryList = [];
    for (var category in categorySelected) {
      categoryList.add(
          "${PostModelFieldNameConstants.category}:${category.toString()}");
    }
    return categoryList;
  }
}
