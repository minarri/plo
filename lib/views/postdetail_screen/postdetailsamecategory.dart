// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:plo/common/widgets/compact_post_widget.dart';
// import 'package:plo/common/widgets/custom_alert_box.dart';
// import 'package:plo/common/widgets/no_post_found.dart';
// import 'package:plo/model/post_model.dart';
// import 'package:plo/repository/firebase_post_repository.dart';
// import 'package:plo/views/postdetail_screen/postDetailScreen.dart';

// final fetchSamePostCategoryProvider = FutureProvider.autoDispose
//     .family<List<PostModel>?, PostModel>((ref, post) async {
//   final future = ref
//       .watch(firebasePostRepositoryProvider)
//       .fetchPostsSameCategoryFromOtherUsers(post.category, post.pid);
//   return null;
// });

// class PostDetailSameCategoryWidget extends ConsumerWidget {
//   final PostModel postKey;

//   const PostDetailSameCategoryWidget({super.key, required this.postKey});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return ref.watch(postDetailCurrentUserFutureProvider).when(
//           data: (user) {
//             if (user == null) return const Icon(Icons.error_outline_rounded);
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 FittedBox(
//                   fit: BoxFit.fitWidth,
//                   child: Row(
//                     children: [
//                       Text("더 많은 똑같은 카테고리의 게시물이 있습니다 ${postKey.category}")
//                     ],
//                   ),
//                 ),
//                 Container(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       ref.watch(fetchSamePostCategoryProvider(postKey)).when(
//                             data: (data) {
//                               if (data == null) {
//                                 return Padding(
//                                   padding: const EdgeInsets.only(top: 10),
//                                   child: SizedBox(
//                                     height: 100,
//                                     child: Center(
//                                       child: Text(
//                                           "관련된 게시물이 ${postKey.category} 카테고리에 더 없습니다"),
//                                     ),
//                                   ),
//                                 );
//                               }
//                               if (data.isEmpty) {
//                                 return const Padding(
//                                   padding: EdgeInsets.only(top: 50),
//                                   child: NoPostFound(
//                                     message: "게시물이 더 이상 존재하지 않습니다",
//                                   ),
//                                 );
//                               }
//                               return GridView.builder(
//                                 shrinkWrap: true,
//                                 physics: const NeverScrollableScrollPhysics(),
//                                 gridDelegate:
//                                     const SliverGridDelegateWithFixedCrossAxisCount(
//                                         crossAxisCount: 3,
//                                         crossAxisSpacing: 10,
//                                         mainAxisSpacing: 10,
//                                         childAspectRatio: 1 / 1.45),
//                                 itemBuilder: (context, index) {
//                                   return InkWell(
//                                     onTap: () async {
//                                       bool proceed = true;
//                                       if (data[index].showWarning) {
//                                         proceed = await AlertBox
//                                                 .showYesOrNoAlertDialogue(
//                                                     context, "계속 하시겠습니까?") ??
//                                             false;
//                                         if (proceed) {
//                                           Navigator.of(context).push(
//                                             MaterialPageRoute(
//                                               builder: (context) =>
//                                                   PostDetailScreen(
//                                                       postKey: data[index]),
//                                             ),
//                                           );
//                                         }
//                                       }
//                                     },
//                                     child: CompactPostWidget(
//                                       post: data[index],
//                                       isBlockedUser: user.blockedUsers
//                                           .contains(data[index].uploadUserUid),
//                                     ),
//                                   );
//                                 },
//                                 itemCount: data.length,
//                               );
//                             },
//                             error: (error, stackTrace) =>
//                                 Text(error.toString()),
//                             loading: () => const CircularProgressIndicator(),
//                           )
//                     ],
//                   ),
//                 )
//               ],
//             );
//           },
//           error: (error, stackTrace) => Text(error.toString()),
//           loading: () => const CircularProgressIndicator(),
//         );
//   }
// }
