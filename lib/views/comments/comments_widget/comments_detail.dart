import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plo/common/utils/functions.dart';
import 'package:plo/model/comments_model.dart';
import 'package:plo/views/comments/comments_widget/single_comment_provider.dart';
import 'package:plo/views/post_write/user_provider/user_provider.dart';
import 'package:plo/views/settings_screen/provider/non_login_provider.dart';

class CommentDetailWidget extends ConsumerStatefulWidget {
  final String postKey;
  final CommentModel commentKey;
  const CommentDetailWidget(
      {super.key, required this.postKey, required this.commentKey});

  @override
  ConsumerState<CommentDetailWidget> createState() =>
      _CommentDetailWidgetState();
}

class _CommentDetailWidgetState extends ConsumerState<CommentDetailWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final comment = ref.watch(singleCommentProvider(
        {'comment': widget.commentKey, 'post': widget.postKey}));
    final currentUser = ref.watch(currentUserProvider);
    final isNotSignedUser = ref.watch(proceedWithoutLoginProvider);
    return SingleChildScrollView(
        child: Column(
      children: [
        Container(
          constraints: BoxConstraints(minHeight: 50, minWidth: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Row(children: [
                                Text(comment.commentsUserNickname),
                                SizedBox(width: 10),
                                Text(
                                    "${Functions.timeDifferenceInText(DateTime.now().difference(comment.uploadTime!.toDate()))}"),
                              ])),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(comment.commentContent)
                  ],
                ),
              )
            ],
          ),
        )
      ],
    ));
  }
}
