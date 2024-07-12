// import 'dart:developer';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:like_button/like_button.dart';
// import 'package:plo/common/widgets/custom_button.dart';
// import 'package:plo/common/widgets/square_image_widget.dart';
// import 'package:plo/model/post_model.dart';
// import 'package:plo/model/types/category_type.dart';
// import 'package:plo/views/post_write/user_provider/user_provider.dart';
// import 'package:plo/views/postdetail_screen/post_detail_controller/post_detail_controller.dart';
// import 'package:plo/views/postdetail_screen/post_like_button.dart';

// class ExpandedPostWidget extends ConsumerWidget {
//   final PostModel post;
//   final bool isBlockedUser;
//   const ExpandedPostWidget(
//       {super.key, required this.post, required this.isBlockedUser});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final Duration duration =
//         DateTime.now().difference(post.uploadTime!.toDate());
//     final user = ref.watch(currentUserProvider);
//     if (user == null)
//       log("important message! currentlySignedInUserProvider is null in PostWidet");
//     return Container(
//       height: 140,
//       padding: const EdgeInsets.all(10),
//       decoration: const BoxDecoration(
//         border: Border(
//           bottom: BorderSide(color: Colors.grey),
//         ),
//       ),
//       width: double.infinity,
//       child: Column(
//         children: [
//           Expanded(
//             flex: 4,
//             child: isBlockedUser
//                 ? FittedBox(
//                     child: Text("이 게시물은 차단당한 유저의 게시물입니다.",
//                         style: Theme.of(context).textTheme.titleLarge),
//                   )
//                 : Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           CustomButton(onPressed: () {}, text: "자유 게시판"),
//                           const SizedBox(width: 10),
//                           CustomButton(onPressed: () {}, text: "정보 게시판"),
//                         ],
//                       ),
//                       // const SizedBox(height: 5),
//                       Row(
//                         children: [
//                           Text(
//                             post.postTitle,
//                             style: const TextStyle(
//                                 fontSize: 20, fontWeight: FontWeight.bold),
//                           ),
//                           const SizedBox(height: 5),
//                           if (post.category == CategoryType.information)
//                             Container(
//                               width: 30,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   color: Colors.grey[300]),
//                               child: Text(
//                                   post.category == CategoryType.information
//                                       ? "정보"
//                                       : "자유",
//                                   style: const TextStyle(color: Colors.grey)),
//                             ),
//                           const SizedBox(height: 2),
//                           Text(
//                             "작성자: ${post.userNickname}",
//                             style: const TextStyle(
//                                 fontSize: 10, color: Colors.grey),
//                           ),
//                         ],
//                       ),
//                       // const SizedBox(height: 5),
//                       Expanded(
//                         child: Text(post.postContent,
//                             style: Theme.of(context).textTheme.bodySmall,
//                             maxLines: 5,
//                             overflow: TextOverflow.ellipsis),
//                       ),
//                       // const SizedBox(height: 5),
//                       Row(
//                         children: [
//                           const Icon(Icons.visibility_outlined, size: 10),
//                           const SizedBox(width: 2),
//                           Text(
//                             post.postViewList == null
//                                 ? "0"
//                                 : post.postViewList.length.toString(),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//           ),
//           Expanded(
//             flex: 3,
//             child: isBlockedUser
//                 ? Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color: Colors.grey[300],
//                     ),
//                     child: Center(
//                         child: Icon(
//                       Icons.warning,
//                       size: 50,
//                       color: Colors.red[100],
//                     )))
//                 : (post.showWarning)
//                     ? Container(
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             color: Colors.grey[300]),
//                         child: Center(
//                           child: Icon(Icons.warning,
//                               color: Colors.red[300], size: 50),
//                         ),
//                       )
//                     : (post.contentImageUrlList.isEmpty)
//                         ? Container(
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                                 color: Colors.grey[300]),
//                             child: const Center(
//                               child: Icon(Icons.image,
//                                   color: Colors.grey, size: 50),
//                             ))
//                         : SquareImageWidget(
//                             postImageUrl: post.contentImageUrlList[0],
//                           ),
//           ),
//           Expanded(
//               flex: 3,
//               child: Row(
//                 children: [
//                   Icon(
//                     Icons.thumb_up_sharp,
//                   ),
//                   const SizedBox(width: 5),
//                   Text(
//                     post.postLikes == null ? "0" : post.postLikes.toString(),
//                   ),
//                   const SizedBox(width: 15),
//                   Icon(Icons.comment),
//                   // const SizedBox(height: 10),
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color: Colors.lightBlue,
//                     ),
//                     child: PostDetailLikeButton(postKey: post),
//                   ),
//                   // const SizedBox(height: 10),
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: CustomButton(
//                         onPressed: () {},
//                         icon: Icon(Icons.comment),
//                         text: "댓글 쓰기"),
//                   )
//                 ],
//               ))
//         ],
//       ),
//     );
//   }
// }
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plo/common/utils/functions.dart';
import 'package:plo/common/widgets/square_image_widget.dart';
import 'package:plo/model/post_model.dart';
import 'package:plo/model/types/category_type.dart';
import 'package:plo/views/post_write/user_provider/user_provider.dart';

class ExpandedPostWidget extends ConsumerWidget {
  final PostModel post;
  final bool isFromBlockedUser;
  const ExpandedPostWidget(
      {super.key, required this.post, this.isFromBlockedUser = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Duration duration =
        DateTime.now().difference(post.uploadTime!.toDate());
    // log('item widget photoUrls : ${item.photoUrls}');
    // final item = ref.watch(itemDetailProvider(item));
    final user = ref.watch(currentUserProvider);
    if (user == null)
      log('important message! currentlySignedInUserProvider is null in ItemWidget.');
    // final Duration duration =
    //     DateTime.now().difference(item.uploadTime!.toDate());
    return Container(
      height: 500,
      padding: const EdgeInsets.all(10),
      decoration:
          BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey))),
      width: double.infinity,
      child: Column(
        children: [
          // Image section
          Expanded(
            flex: 1,
            child: isFromBlockedUser
                ? FittedBox(
                    child: Text(
                      "This item is from blocked user",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            post.postTitle,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 3),
                          Container(
                            height: 20,
                            width: 90,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.grey,
                            ),
                            child: Center(
                              child: Text(
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[100]),
                                  post.category == CategoryType.information
                                      ? "정보 게시물"
                                      : "자유 게시물"),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 5,
                      ),
                      // Upload time
                      Row(
                        children: [
                          Text(
                            "${Functions.timeDifferenceInText(duration)}",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: Colors.grey),
                          ),
                          Spacer(),
                          Text(post.userNickname,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      // Like, view, comment
                    ],
                  ),
          ),
          Expanded(
              flex: 1,
              child: Row(
                children: [
                  Text(post.postContent,
                      style: Theme.of(context).textTheme.bodyMedium),
                  const Spacer(),
                  Icon(Icons.visibility),
                  const SizedBox(width: 3),
                  Text(post.postViewList == null
                      ? "0"
                      : post.postViewList.length.toString())
                ],
              )),
          Expanded(
            flex: 5,
            child: isFromBlockedUser
                ? Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[300],
                    ),
                    child: Center(child: Icon(Icons.warning)),
                  )
                : (post.showWarning)
                    ? Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[300],
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.visibility_off_rounded,
                            color: Colors.grey,
                            size: 50,
                          ),
                        ),
                      )
                    : (post.contentImageUrlList.isEmpty)
                        ? Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[300],
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.image,
                                color: Colors.grey,
                                size: 50,
                              ),
                            ),
                          )
                        : SquareImageWidget(
                            postImageUrl: post.contentImageUrlList[0]),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                //have to change this to different Icon where when user liked it it changes the heart to filled and if user is null or has not liked the post it should be an empty heart.
                user == null || !user.likedPosts.contains(post.pid)
                    ? Icon(Icons.thumb_up_sharp)
                    : Icon(Icons.heart_broken),
                Text(post.postLikes == null ? '0' : post.postLikes.toString()),
                const SizedBox(width: 10),
                Icon(Icons.comment),
              ],
            ),
          )
        ],
      ),
    );
  }
}
