import 'package:flutter/material.dart';
import 'package:plo/common/widgets/loading_widgets/loading_expanded_post.dart';

class ExpandedPostListLoadingWidget extends StatelessWidget {
  const ExpandedPostListLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => const LoadingExpandedPostWidget(),
      separatorBuilder: (context, index) => const Divider(),
      itemCount: 4,
    );
  }
}
