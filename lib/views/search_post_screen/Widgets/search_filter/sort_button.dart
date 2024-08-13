import 'package:flutter/material.dart';
import 'package:plo/model/state_model/search_filter_options_model.dart';

import 'sortby_sheet.dart';

class SearchSortButton extends StatelessWidget {
  final FilterOptions filterOptions;
  const SearchSortButton({super.key, required this.filterOptions});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showModalBottomSheet(
          isScrollControlled: true,
          showDragHandle: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          context: context,
          builder: (context) => const SortByBottomsheet(),
        );
      },
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.sort_outlined),
          Text(
            "Sort",
            style: TextStyle(color: Colors.black),
          )
        ],
      ),
    );
  }
}
