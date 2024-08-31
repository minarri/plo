import 'package:flutter/material.dart';
import 'package:plo/model/state_model/search_filter_options_model.dart';

import 'filter_side_bar.dart';

class SearchFilterButton extends StatelessWidget {
  final FilterOptions filterOptions;
  const SearchFilterButton({super.key, required this.filterOptions});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).push(
          RawDialogRoute(
            transitionBuilder: (context, animation, secondaryAnimation, child) {
              var begin = const Offset(1, 0);
              var end = const Offset(0.2, 0);
              var curve = Curves.easeIn;
              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
            pageBuilder: (context, animation, secondaryAnimation) {
              return FilterSideBar(
                tempFilterOptions: filterOptions,
              );
            },
          ),
        );
      },
      child: const Icon(Icons.filter_list_outlined),
    );
  }
}
