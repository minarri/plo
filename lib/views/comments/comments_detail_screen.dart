import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plo/common/providers/singlepost.dart';
import 'package:plo/model/comments_model.dart';
import 'package:plo/model/post_model.dart';
import 'package:plo/model/user_model.dart';
import 'package:plo/repository/firebase_user_repository.dart';
import 'package:plo/views/comments/comments_widget/commentlists/comments_list_controller.dart';
import 'package:plo/views/comments/comments_widget/comments_detail.dart';
import 'package:plo/views/comments/comments_widget/comments_profile.dart';
import 'package:plo/views/comments/comments_widget/single_comment_provider.dart';
import 'package:plo/views/post_write/user_provider/user_provider.dart';
import 'package:plo/views/settings_screen/provider/non_login_provider.dart';

final commentUploaderProvider =
    FutureProvider.autoDispose.family<UserModel?, String>((ref, userId) async {
  final userFetched =
      await ref.watch(firebaseUserRepositoryProvider).fetchUserbyUid(userId);
  return userFetched;
});

final postDetailCurrentUserFutureProvider =
    FutureProvider.autoDispose<UserModel?>((ref) async {
  final user = await ref.watch(firebaseUserRepositoryProvider).fetchUser();
  return user;
});

class CommentDetailScreen extends ConsumerWidget {
  final CommentModel commentKey;
  final PostModel postKey;
  const CommentDetailScreen(
      {super.key, required this.commentKey, required this.postKey});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final state = ref.watch(
      commentListController(postKey.pid),
    );
    final isMyComment = ref.watch(proceedWithoutLoginProvider)
        ? false
        : commentKey.commentsUserUid == user!.userUid;
    final post = ref.watch(singlePostProvider(postKey));
    final comment = ref.watch(
        singleCommentProvider({'comment': commentKey, 'pid': postKey.pid}));

    return ref.watch(commentUploaderProvider(comment.commentsUserUid)).when(
          data: (data) {
            return state.isLoading
                ? CircularProgressIndicator()
                : Material(
                    child: SafeArea(
                      child: Scaffold(
                          body: Stack(children: [
                        SingleChildScrollView(
                            child: Container(
                                child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CommentProfileWidget(
                                    commentKey: commentKey,
                                    postKey: postKey.pid),
                                const SizedBox(width: 10),
                                CommentDetailWidget(
                                    postKey: postKey.pid,
                                    commentKey: commentKey)
                              ],
                            ),
                          ],
                        )))
                      ])),
                    ),
                  );
          },
          loading: () => CircularProgressIndicator(),
          error: (error, stackTrace) =>
              const Icon(Icons.error_outline, size: 20),
        );
  }
}
