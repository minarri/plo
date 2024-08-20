import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plo/common/widgets/profile_circular_image.dart';
import 'package:plo/model/comments_model.dart';
import 'package:plo/model/post_model.dart';
import 'package:plo/views/comments/comments_widget/comments_screen.dart';
import 'package:plo/views/comments/comments_widget/single_comment_provider.dart';
import 'package:plo/views/postdetail_screen/postdetailProfile.dart';

final commentDetailProfileErrorProvider =
    StateProvider.autoDispose<bool>((ref) => false);

class CommentProfileWidget extends ConsumerWidget {
  final CommentModel commentKey;
  const CommentProfileWidget({super.key, required this.commentKey});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postDetailProfileError = ref.watch(commentDetailProfileErrorProvider);

    final comment = ref.watch(singleCommentProvider(commentKey));
    final uploader =
        ref.watch(commentUploaderProvider(comment.commentsUserUid));
    return uploader.when(
        loading: () => const PostDetailProfileLoadingWidget(),
        error: (error, stackTrace) => const Text("프로필을 불러오던 중 에러가 났습니다"),
        data: (commentUploader) {
          if (commentUploader == null) return const Text("유저를 찾을 수 없습니다.");
          return Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 40,
                height: 40,
                child: DefaultProfileImageWidget(
                    imageUrl: commentUploader.profileImageUrl),
              ),
            ],
          );
        });
  }
}
