import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plo/common/widgets/default_button_widget.dart';
import 'package:plo/common/widgets/modal_bottomsheet/default_modal_bottom.dart';

import '../../../../model/types/category_type.dart';
import '../../Controllers/filter_options_controller.dart';

final tempCategoryProvider = StateProvider.autoDispose<Set<CategoryType>>((ref) => {});

class CategoryBottomSheet extends ConsumerStatefulWidget {
  const CategoryBottomSheet({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FilterPageCategoryBottomSheetState();
}

class _FilterPageCategoryBottomSheetState extends ConsumerState<CategoryBottomSheet> {
  late Set<CategoryType> entireCategoryList = {};

  @override
  void initState() {
    super.initState();
    entireCategoryList = CategoryType.categoryOptions.toSet();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final category = ref.watch(tempFilterOptionsProvider).categorySelected;
      final isAllSelected = CategoryType.categoryOptions.toSet().difference(category);
      // print("isAllSelected: $isAllSelected");
      ref.watch(tempCategoryProvider.notifier).state = isAllSelected.isEmpty ? {} : category;
    });
    entireCategoryList = CategoryType.categoryOptions.toSet();
  }

  @override
  Widget build(BuildContext context) {
    final tempCategory = ref.watch(tempCategoryProvider);
    const categoryList = CategoryType.categoryOptions;
    return DefaultModalBottomSheet(
        title: "Set the category",
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CategoryBottomSheetCategoryWidget(categoryType: categoryList[0], isAll: true),
                CategoryBottomSheetCategoryWidget(
                  categoryType: categoryList[0],
                ),
                CategoryBottomSheetCategoryWidget(
                  categoryType: categoryList[1],
                ),
              ],
            ),
            const SizedBox(height: 10),
            DefaultButtonWidget(
                text: "Apply",
                onPressed: () {
                  // print("final $tempCategory");
                  if (tempCategory.isEmpty) {
                    ref.watch(tempFilterOptionsProvider.notifier).setCategorySelected(CategoryType.categoryOptions.toSet());
                  } else {
                    ref.watch(tempFilterOptionsProvider.notifier).setCategorySelected(tempCategory);
                  }
                  Navigator.pop(context);
                })
          ],
        ));
  }
}

class CategoryBottomSheetCategoryWidget extends ConsumerWidget {
  final CategoryType categoryType;
  final bool isAll;
  const CategoryBottomSheetCategoryWidget({super.key, this.isAll = false, required this.categoryType});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isChecked = ref.watch(tempCategoryProvider).contains(categoryType);
    final tempCategory = ref.watch(tempCategoryProvider);
    final isAllSelected = tempCategory.isEmpty;
    return Expanded(
      child: InkWell(
        onTap: () {
          Set<CategoryType> set = {};
          for (int i = 0; i < tempCategory.length; i++) {
            set.add(tempCategory.elementAt(i));
          }

          if (isAll && !isAllSelected) {
            set = {};
            ref.watch(tempCategoryProvider.notifier).state = set;
            return;
          }

          if (isChecked) {
            set.remove(categoryType);
            ref.watch(tempCategoryProvider.notifier).state = set;
          } else {
            set.add(categoryType);
            ref.watch(tempCategoryProvider.notifier).state = set;
          }
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          height: 100,
          // decoration: BoxDecoration(border: Border.all()),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 8,
                child: isAll
                    ? Padding(
                        padding: EdgeInsets.zero,
                        child: Text(
                          "All",
                          style:
                              isChecked ? const TextStyle(color: Color.fromARGB(255, 60, 118, 231)) : const TextStyle(color: Colors.black),
                        ))
                    : Text(
                        categoryType.name,
                        style: isChecked ? const TextStyle(color: Color.fromARGB(255, 60, 118, 231)) : const TextStyle(color: Colors.black),
                      ),
              ),
              Expanded(
                flex: 2,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    isAll ? "All" : categoryType.toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
