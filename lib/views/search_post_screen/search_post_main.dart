import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plo/views/search_post_screen/filter_options_controller.dart';

import '../../common/utils/log_util.dart';
import 'search_post_controller.dart';
import 'Widgets/post_result_widget.dart';

class SearchPostsMain extends ConsumerStatefulWidget {
  const SearchPostsMain({super.key});

  @override
  _SearchPostsMainState createState() => _SearchPostsMainState();
}

class _SearchPostsMainState extends ConsumerState<SearchPostsMain> {
  bool isFieldEmpty = false;
  List<String> searchHistory = [];
  TextEditingController searchQueryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchQueryController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final filterOptions = ref.watch(filterOptionsControllerProvider);
    final searchPosts = ref.watch(searchPostsControllerProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SearchBar(
                controller: searchQueryController,
                trailing: [
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () async {
                      if (searchQueryController.text.isEmpty) {
                        setState(() {
                          isFieldEmpty = true;
                        });
                        return;
                      }
                      await ref
                          .read(searchPostsControllerProvider.notifier)
                          .setSearchQuery(searchQueryController.text);
                    },
                  )
                ],
                hintText: "검색어를 입력해주세요",
                onSubmitted: (_) async {
                  logToConsole("Search button pressed");
                  if (searchQueryController.text.isEmpty) {
                    logToConsole("searchQuery is empty");
                    setState(() {
                      isFieldEmpty = true;
                    });
                    return;
                  }
                  logToConsole(
                      "Search query submitted: ${searchQueryController.text}");
                  await ref
                      .read(searchPostsControllerProvider.notifier)
                      .setSearchQuery(searchQueryController.text);
                },
                // onTapOutside: (event) => FocusScope.of(context).unfocus(),
              ),
              Expanded(
                child: searchPosts == null
                    ? const Center(child: CircularProgressIndicator())
                    : PostResultWidget(
                        filterOptions: filterOptions,
                        searchQuery: searchQueryController.text,
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
