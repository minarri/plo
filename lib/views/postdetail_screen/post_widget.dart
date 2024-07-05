import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plo/common/utils/functions.dart';
import 'package:plo/common/utils/log_util.dart';
import 'package:plo/model/post_model.dart';
import 'package:plo/views/post_write/user_provider/user_provider.dart';

class PostWidget extends ConsumerWidget {
  final PostModel post;
  const PostWidget({super.key, required this.post});

  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    if (user == null)
      logToConsole(
          "Important Message! CurrentlySignedUserProvider is null in PostWidget.");
    final Duration duration =
        DateTime.now().difference(post.uploadTime!.toDate());
    return Container(
      height: 100,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey),
        ),
      ),
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: (post.contentImageUrlList.length == 0)
                ? Image.asset("assets/images/profile_default.png",
                    fit: BoxFit.cover)
                : Image.asset("assets/images/profile_default.png",
                    fit: BoxFit.cover),
          ),
          SizedBox(width: 5),
          Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.postTitle,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text(
                  "${Functions.timeDifferenceInText(duration)}",
                  style: TextStyle(color: Colors.grey[400], fontSize: 12),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      user == null
                          ? Icon(
                              Icons.favorite,
                              color: Colors.blue,
                              size: 15,
                            )
                          : Icon(
                              size: 15,
                              Icons.favorite,
                              color: user.likedPosts.contains(post.pid)
                                  ? Colors.red
                                  : Colors.black),
                      Text(
                        post.postLikes == null
                            ? "0"
                            : post.postLikes.toString(),
                      ),
                      SizedBox(width: 10),
                      Icon(
                        Icons.comment,
                        size: 15,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
