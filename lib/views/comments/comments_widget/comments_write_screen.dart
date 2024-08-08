import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plo/common/providers/singlepost.dart';
import 'package:plo/model/comments_model.dart';
import 'package:plo/model/post_model.dart';
import 'package:plo/model/state_model/create_edit_comment_model.dart';
import 'package:plo/model/user_model.dart';
import 'package:plo/repository/firebase_post_repository.dart';
import 'package:plo/repository/firebase_user_repository.dart';
import 'package:plo/views/comments/comments_controller.dart';
import 'package:plo/views/comments/comments_widget/commentlist_screen.dart';
import 'package:plo/views/comments/comments_widget/commentlists/comments_list_controller.dart';
import 'package:plo/views/comments/comments_widget/commentlists/comments_list_provider.dart';
import 'package:plo/views/comments/comments_provider.dart';
import 'package:plo/views/comments/comments_widget/comments_contentform.dart';

final commentUploaderProvider =
    FutureProvider.autoDispose.family<UserModel?, String>((ref, userUid) async {
  final userFetched =
      ref.watch(firebaseUserRepositoryProvider).fetchUserbyUid(userUid);
  return userFetched;
});
final postDetailFutureProvider =
    FutureProvider.autoDispose.family<PostModel?, String>((ref, postPid) async {
  final firebasePostRepository = ref.watch(firebasePostRepositoryProvider);
  return await firebasePostRepository.fetchPostByPostUid(postPid);
});
final commentDetailCurrentUserFutureProvider =
    FutureProvider.autoDispose<UserModel?>((ref) async {
  final user = await ref.watch(firebaseUserRepositoryProvider).fetchUser();
  return user;
});

class CommentWriteScreen extends ConsumerStatefulWidget {
  final CreateEditCommentModel? editCommentInformation;
  final PostModel postKey;

  const CommentWriteScreen({
    super.key,
    this.editCommentInformation,
    required this.postKey,
  });
  @override
  ConsumerState<CommentWriteScreen> createState() => _CommentWriteScreenState();
}

class _CommentWriteScreenState extends ConsumerState<CommentWriteScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.editCommentInformation != null) {
        ref
            .watch(createEditCommentController.notifier)
            .initFieldForEdit(widget.editCommentInformation!);
        ref
            .watch(createEditCommentStateProvider.notifier)
            .initForEdit(widget.editCommentInformation!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // var commentState = ref.watch(createEditCommentStateProvider);
    final post = ref.watch(postDetailFutureProvider(widget.postKey.pid));
    return SafeArea(
      child: post.when(
        data: (post) {
          if (post == null) {
            return Center(child: Text("게시물이 존재하지 않습니다"));
          }
          ref.watch(commentListController(post.pid));
          // return SizedBox(
          //   width: MediaQuery.of(context).size.width,
          //   height: MediaQuery.of(context).size.height,
          //   child: Column(
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       Flexible(
          //         fit: FlexFit.tight,
          //         child: CommentListScreen(
          //           postKey: post,
          //         ),
          //       ),
          //       Padding(
          //           padding: const EdgeInsets.symmetric(vertical: 8),
          //           child: CommentContentForm(formKey: _formKey)),
          //       TextButton(
          //         onPressed: () async {
          //           showDialog(
          //               context: context,
          //               barrierDismissible: false,
          //               builder: (context) =>
          //                   Center(child: CircularProgressIndicator()));
          //           final result = await ref
          //               .read(createEditCommentController.notifier)
          //               .uploadComment(
          //                   formKey: _formKey, postPid: widget.postKey.pid);
          //           // if (!result) {
          //           //   Navigator.of(context).pop();

          //           //   ScaffoldMessenger.of(context).showSnackBar(
          //           //     SnackBar(
          //           //       content: Text("댓글을 올리는데 실패 했습니다."),
          //           //     ),
          //           //   );
          //           // }
          //           if (result == true) {
          //             ref.refresh(commentListController(widget.postKey.pid));
          //             Navigator.of(context).pop();
          //           } else {
          //             Navigator.of(context).pop();
          //           }
          //         },
          //         child: const Text("글 작성"),
          //       ),
          //     ],
          //   ),
          // );
          return LayoutBuilder(builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints:
                    BoxConstraints(maxHeight: constraints.maxHeight - 150),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(
                          maxHeight: constraints.maxHeight - 150),
                    ),
                    CommentListScreen(
                      postKey: post,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: CommentContentForm(formKey: _formKey),
                    ),
                    TextButton(
                      onPressed: () async {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) =>
                                Center(child: CircularProgressIndicator()));
                        final result = await ref
                            .read(createEditCommentController.notifier)
                            .uploadComment(
                                formKey: _formKey, postPid: widget.postKey.pid);
                        Navigator.of(context).pop();
                        if (result == true) {
                          ref.refresh(
                              commentListController(widget.postKey.pid));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("댓글을 올리는데 실패 했습니다."),
                            ),
                          );
                        }
                      },
                      child: const Text("글 작성"),
                    ),
                  ],
                ),
              ),
            );
          });
        },
        loading: () => CircularProgressIndicator(),
        error: ((error, stackTrace) => Center(
              child: Text(
                "Error: ${error.toString()}",
              ),
            )),
      ),
    );
  }
}

// class CommentsList extends ConsumerWidget {
//   final String postId;

//   const CommentsList({Key? key, required this.postId}) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final comments = ref.watch(commentListProvider(postId));

//     return ListView.builder(
//       physics: NeverScrollableScrollPhysics(),
//       shrinkWrap: true,
//       itemCount: comments.length,
//       itemBuilder: (context, index) {
//         final comment = comments[index];
//         return ListTile(
//           title: Text(comment.commentContent),
//           subtitle: Text(comment.commentsUserNickname),
//         );
//       },
//     );
//   }
// }
