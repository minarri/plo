import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plo/common/providers/singlepost.dart';
import 'package:plo/common/widgets/custom_alert_box.dart';
import 'package:plo/common/widgets/modal_bottomsheet/default_modal_bottom.dart';
import 'package:plo/common/widgets/modal_bottomsheet/modal_bottom_icon.dart';
import 'package:plo/model/comments_model.dart';
import 'package:plo/model/post_model.dart';
import 'package:plo/model/state_model/create_edit_comment_model.dart';
import 'package:plo/services/delete_service.dart';
import 'package:plo/views/comments/comments_widget/comments_write_screen.dart';
import 'package:plo/views/comments/comments_widget/single_comment_provider.dart';
import 'package:plo/views/home_screen/widgets/default_progress_result.dart';

class CommentDetailCurrentUserKebobicon extends ConsumerWidget {
  final CommentModel commentKey;
  final BuildContext parentContext;
  final PostModel postKey;

  const CommentDetailCurrentUserKebobicon(
      {super.key,
      required this.commentKey,
      required this.parentContext,
      required this.postKey});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final comment = ref.watch(singleCommentProvider(commentKey));
    final post = ref.watch(singlePostProvider(postKey));
    return DefaultModalBottomSheet(
        title: "댓글 관리",
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ModalBottomSheetIcon(
              title: "수정",
              onTap: () async {
                Navigator.of(context).pop();
                final result = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CommentWriteScreen(
                      postKey: post,
                      editCommentInformation:
                          CreateEditCommentModel.initForEditComment(comment),
                    ),
                  ),
                );
                // if (result == true) {
                //   if (context.mounted) {
                //     await ref
                //         .watch(singleCommentProvider(commentKey).notifier)
                //         .updateCommentFromServer();
                //   }
                // }
                if (result == true) {
                  ref
                      .refresh(singleCommentProvider(commentKey).notifier)
                      .updateCommentFromServer();
                }
              },
              icon: const Icon(Icons.edit),
            ),
            ModalBottomSheetIcon(
                title: "삭제",
                icon: const Icon(Icons.delete),
                onTap: () async {
                  if (!context.mounted) {
                    return;
                  }
                  final isConfirmed = await AlertBox.showYesOrNoAlertDialogue(
                    context,
                    "정말로 삭제하시겠습니까?",
                  );
                  if (isConfirmed ?? false) {
                    try {
                      final result = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DefaultProgressResult(
                            future: ref
                                .watch(deleteServiceProvider)
                                .deleteComment(post.pid, comment.cid),
                          ),
                        ),
                      );
                      if (result == true) {
                        if (parentContext.mounted) {
                          Navigator.of(parentContext).pop();
                        }
                      }
                    } catch (e) {
                      log("${e.toString()}");
                    }
                  }
                })
          ],
        ));
  }
}
