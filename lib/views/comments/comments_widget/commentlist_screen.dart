import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plo/common/widgets/loading_widgets/expanded_loading_post.dart';
import 'package:plo/common/widgets/loading_widgets/loading_expanded_comments.dart';
import 'package:plo/common/widgets/loading_widgets/loading_expanded_post.dart';
import 'package:plo/common/widgets/no_comments_found.dart';
import 'package:plo/common/widgets/no_more_comments.dart';
import 'package:plo/common/widgets/no_more_post.dart';
import 'package:plo/model/comments_model.dart';
import 'package:plo/model/post_model.dart';
import 'package:plo/model/user_model.dart';
import 'package:plo/repository/firebase_comments_repository.dart';
import 'package:plo/repository/firebase_user_repository.dart';
import 'package:plo/views/comments/comments_detail_screen.dart';
import 'package:plo/views/comments/comments_widget/commentlists/comments_list_controller.dart';
import 'package:plo/views/comments/comments_widget/commentlists/comments_list_provider.dart';

final commentListCurrentUserProvider =
    FutureProvider.autoDispose<UserModel?>((ref) async {
  final user = await ref.watch(firebaseUserRepositoryProvider).fetchUser();
  return user;
});

class CommentListScreen extends ConsumerWidget {
  final PostModel postKey;
  const CommentListScreen({super.key, required this.postKey});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(commentListController(postKey.pid));
    final comments = ref.watch(commentListProvider(postKey.pid));
    return RefreshIndicator(
      onRefresh: () async {
        ref.refresh(commentListController(postKey.pid));
        ref.refresh(commentListProvider(postKey.pid));
      },
      child: ref.watch(commentListCurrentUserProvider).when(
            data: (currentUser) {
              return Container(
                padding: EdgeInsets.all(8),
                child: state.isLoading
                    // ? const ExpandedPostListLoadingWidget()
                    ? CircularProgressIndicator()
                    : comments.isEmpty
                        ? const NoCommentsFound()
                        : Container(
                            child: ListView.separated(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                controller: ref
                                    .read(commentListController(postKey.pid)
                                        .notifier)
                                    .scrollController,
                                itemBuilder: (context, index) {
                                  if (index >= comments.length) {
                                    return ref
                                            .read(commentListController(
                                                    postKey.pid)
                                                .notifier)
                                            .isCommentAllLoaded
                                        ? Container(height: 30, width: 30)
                                        : LoadingExpandedCommentsWidget();
                                  }
                                  //commentsDetailScreen 여기 들어갈거임
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    child: CommentDetailScreen(
                                        commentKey: comments[index]),
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    Container(),
                                itemCount: comments.length + 1),
                          ),
              );
            },
            error: (error, stackTrace) => const Text("Unknown Error occured"),
            loading: () => const Center(child: CircularProgressIndicator()),
          ),
    );
  }
}
