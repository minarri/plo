import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:like_button/like_button.dart';
import 'package:plo/common/providers/singlepost.dart';
import 'package:plo/model/post_model.dart';
import 'package:plo/views/post_write/user_provider/user_provider.dart';
import 'package:plo/views/postdetail_screen/post_detail_controller/post_detail_controller.dart';

class PostDetailLikeButton extends ConsumerStatefulWidget {
  final PostModel postKey;
  const PostDetailLikeButton({super.key, required this.postKey});

  @override
  ConsumerState<PostDetailLikeButton> createState() =>
      _PostDetailLikeButtonState();
}

class _PostDetailLikeButtonState extends ConsumerState<PostDetailLikeButton> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final post = ref.watch(singlePostProvider(widget.postKey));
    final user = ref.watch(currentUserProvider);
    const int defaultLike = 0;
    return user == null
        ? const CircularProgressIndicator()
        : LikeButton(
            size: 20,
            circleColor:
                const CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
            bubblesColor: const BubblesColor(
                dotPrimaryColor: Color(0xff33b5e5),
                dotSecondaryColor: Color(0xff0099cc)),
            likeCount: defaultLike,
            likeBuilder: (bool isLiked) {
              return Icon(Icons.favorite,
                  size: 20, color: isLiked ? Colors.pinkAccent : Colors.grey);
            },
            countPostion: CountPostion.bottom,
            onTap: (bool isLiked) async {
              final result = await ref
                  .read(postDetailControllerProvider.notifier)
                  .toggleLike(widget.postKey, post);
              return result;
            },
          );
  }
}
