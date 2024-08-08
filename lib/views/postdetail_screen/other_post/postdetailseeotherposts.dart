// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:plo/common/widgets/compact_post_widget.dart';
// import 'package:plo/common/widgets/custom_alert_box.dart';
// import 'package:plo/common/widgets/custom_app_bar.dart';
// import 'package:plo/common/widgets/shimmer_style.dart';
// import 'package:plo/model/comments_model.dart';
// import 'package:plo/model/post_model.dart';
// import 'package:plo/repository/firebase_post_repository.dart';
// import 'package:plo/views/postdetail_screen/postDetailScreen.dart';

// final postDetailFetchedAllUserPostProvider = FutureProvider.autoDispose
//     .family<List<PostModel>?, String>((ref, userUid) async {
//   return await ref
//       .watch(firebasePostRepositoryProvider)
//       .getUsersActivePost(userUid: userUid);
// });

// class PostDetailSeeOtherPostsDetailPage extends ConsumerWidget {
//   final String userUid;
//   final CommentModel commentKey;
//   const PostDetailSeeOtherPostsDetailPage(
//       {super.key, required this.userUid, required this.commentKey});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return ref.watch(postDetailCurrentUserFutureProvider).when(
//         data: (currentUser) {
//           if (currentUser == null) {
//             return const Icon(Icons.error_outline, size: 40);
//           }
//           return ref.watch(postUploaderProvider(userUid)).when(
//               error: (error, stackTrace) => Scaffold(
//                     body: Center(
//                       child: Text(error.toString()),
//                     ),
//                   ),
//               loading: () => const Scaffold(
//                     body: Center(
//                       child: CircularProgressIndicator(),
//                     ),
//                   ),
//               data: (user) {
//                 if (user == null) return const Text("유저가 존재하지 않습니다");
//                 return Scaffold(
//                   appBar: BackButtonAppBar(
//                     title: "${user.userNickname}님의 게시물",
//                   ),
//                   body: SafeArea(
//                     child: Padding(
//                         padding: const EdgeInsets.all(8),
//                         child: SingleChildScrollView(
//                           child: Column(
//                             children: [
//                               ref
//                                   .watch(postDetailFetchedAllUserPostProvider(
//                                       user.userUid))
//                                   .when(
//                                       error: (error, stackTrace) =>
//                                           const Center(
//                                               child: Icon(Icons.error_outline,
//                                                   size: 40)),
//                                       loading: () => GridView.builder(
//                                             physics:
//                                                 const NeverScrollableScrollPhysics(),
//                                             shrinkWrap: true,
//                                             gridDelegate:
//                                                 const SliverGridDelegateWithFixedCrossAxisCount(
//                                                     crossAxisCount: 3,
//                                                     mainAxisSpacing: 5,
//                                                     crossAxisSpacing: 5),
//                                             itemCount: 6,
//                                             itemBuilder: (context, index) {
//                                               Column(
//                                                 children: [
//                                                   Expanded(
//                                                     flex: 3,
//                                                     child:
//                                                         ShimmerIndividualWidget(
//                                                       child: Container(
//                                                         decoration:
//                                                             const BoxDecoration(
//                                                                 borderRadius:
//                                                                     BorderRadius
//                                                                         .all(
//                                                                   Radius
//                                                                       .circular(
//                                                                           10),
//                                                                 ),
//                                                                 color: Colors
//                                                                     .grey),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   const SizedBox(height: 10),
//                                                   Expanded(
//                                                     flex: 1,
//                                                     child:
//                                                         ShimmerIndividualWidget(
//                                                       child: Container(
//                                                         decoration:
//                                                             const BoxDecoration(
//                                                           borderRadius:
//                                                               BorderRadius.all(
//                                                             Radius.circular(10),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   const SizedBox(height: 10),
//                                                   Expanded(
//                                                     flex: 1,
//                                                     child: Container(
//                                                       decoration:
//                                                           const BoxDecoration(
//                                                         borderRadius:
//                                                             BorderRadius.all(
//                                                                 Radius.circular(
//                                                                     10)),
//                                                       ),
//                                                     ),
//                                                   )
//                                                 ],
//                                               );
//                                               return null;
//                                             },
//                                           ),
//                                       data: (data) {
//                                         if (data == null) {
//                                           return const Icon(
//                                               Icons.error_outline);
//                                         }
//                                         return GridView.builder(
//                                           gridDelegate:
//                                               const SliverGridDelegateWithFixedCrossAxisCount(
//                                                   crossAxisCount: 3,
//                                                   crossAxisSpacing: 5,
//                                                   mainAxisSpacing: 5),
//                                           itemBuilder: (context, index) {
//                                             if (data.isEmpty) {
//                                               return const PostDetailUserOtherPostsErrorWidget(
//                                                   message:
//                                                       "게시물이 더 이상 존재하지 않습니다");
//                                             }
//                                             return InkWell(
//                                                 onTap: () async {
//                                                   bool proceed = true;
//                                                   if (data[index].showWarning) {
//                                                     proceed = await AlertBox
//                                                             .showYesOrNoAlertDialogue(
//                                                                 context,
//                                                                 "계속 하시겠습니까?") ??
//                                                         false;
//                                                     if (proceed) {
//                                                       Navigator.of(context)
//                                                           .push(
//                                                         MaterialPageRoute(
//                                                           builder: (context) {
//                                                             return PostDetailScreen(
//                                                               postKey:
//                                                                   data[index],
//                                                               commentKey:
//                                                                   commentKey,
//                                                             );
//                                                           },
//                                                         ),
//                                                       );
//                                                     }
//                                                   }
//                                                 },
//                                                 child: CompactPostWidget(
//                                                   post: data[index],
//                                                   isBlockedUser: currentUser
//                                                       .blockedUsers
//                                                       .contains(data[index]
//                                                           .uploadUserUid),
//                                                 ));
//                                           },
//                                           itemCount: data == null
//                                               ? 0
//                                               : data.length > 6
//                                                   ? 6
//                                                   : data.length,
//                                         );
//                                       }),
//                             ],
//                           ),
//                         )),
//                   ),
//                 );
//               });
//         },
//         error: (error, stackTrace) => const Scaffold(
//               body: Icon(Icons.error_outline, size: 40),
//             ),
//         loading: () => const Scaffold(
//               body: Center(
//                 child: CircularProgressIndicator(),
//               ),
//             ));
//   }
// }

// class PostDetailUserOtherPostsErrorWidget extends StatelessWidget {
//   final String message;
//   const PostDetailUserOtherPostsErrorWidget({super.key, required this.message});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         width: double.infinity,
//         padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const Icon(Icons.error_rounded, size: 50, color: Colors.red),
//             const SizedBox(height: 20),
//             Text(message, style: Theme.of(context).textTheme.bodyMedium)
//           ],
//         ));
//   }
// }
