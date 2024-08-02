// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:plo/views/search_post_screen/filter_options_controller.dart';

// import '../../../common/utils/log_util.dart';
// import '../../../common/widgets/post_list_widget.dart';
// import '../../../model/post_model.dart';
// import '../../../model/state_model/search_filter_options_model.dart';
// import '../../../services/search_service.dart';

// class SearchResultWidget extends ConsumerStatefulWidget {
//   final String searchQuery;
//   const SearchResultWidget({super.key, required this.searchQuery});

//   @override
//   ConsumerState<SearchResultWidget> createState() => _SearchResultWidgetState();
// }

// class _SearchResultWidgetState extends ConsumerState<SearchResultWidget> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       ref.watch(filterOptionsControllerProvider.notifier).setSearchQuery(widget.searchQuery);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final filterOptions = ref.watch(filterOptionsControllerProvider);
//     // TODO: implement build
//     return PostResultWidget(filterOptions: filterOptions);
//   }
// }


