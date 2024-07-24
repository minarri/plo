import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plo/common/widgets/square_image_widget.dart';
import 'package:plo/model/post_model.dart';

class CompactPostWidget extends ConsumerWidget {
  final PostModel post;
  final bool isBlockedUser;
  const CompactPostWidget(
      {super.key, required this.post, this.isBlockedUser = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.transparent),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 10,
              child: isBlockedUser
                  ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[300],
                      ),
                      child: Center(
                        child:
                            Icon(Icons.error_rounded, color: Colors.red[400]),
                      ),
                    )
                  : post.showWarning
                      ? Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[300]),
                          child: const Center(
                            child: Icon(
                              Icons.visibility_off,
                              color: Colors.grey,
                              size: 50,
                            ),
                          ),
                        )
                      : SquareImageWidget(
                          postImageUrl: post.contentImageUrlList.first),
            ),
            Expanded(
              flex: 2,
              child: Text(isBlockedUser ? "차단당한 유저입니다" : post.postTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium),
            ),
          ],
        ));
  }
}
