// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:plo/model/post_model.dart';
// import 'package:plo/repository/firebase_post_repository.dart';
// import 'package:plo/views/postdetail_screen/postDetailScreen.dart';

// final fetchUsesOtherPostProvider = FutureProvider.autoDispose
//     .family<List<PostModel?>, PostModel>((ref, post) async {
//   final futurePost = ref.watch(firebasePostRepository).fetchUsersSixOtherPosts(
//       userUid: post.uploadUserUid, excludePostUid: post.pid);
// });

// class PostDetailUserOtherPostsWidget extends ConsumerWidget {
//   final PostModel postKey;

//   PostDetailUserOtherPostsWidget({super.key, required this.postKey});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return ref.watch(postDetailCurrentUserFutureProvider).when(data: (user) {
//       if (user == null)
//         return Icon(
//           Icons.error_outline,
//           size: 30,
//         );
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           InkWell(onTap: () {
//             Navigator.of(context).push(
//               MaterialPageRoute(
//                 builder: (context) {
//                   return PostDetailUserOtherPostsWidget(postKey: postKey);
//                 },
//               ),
//             );
//           })
//         ],
//       );
//     });
//   }
// }
