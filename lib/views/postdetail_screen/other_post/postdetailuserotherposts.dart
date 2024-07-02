import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plo/common/widgets/compact_post_widget.dart';
import 'package:plo/common/widgets/custom_alert_box.dart';
import 'package:plo/common/widgets/no_more_post.dart';
import 'package:plo/common/widgets/shimmer_style.dart';
import 'package:plo/model/post_model.dart';
import 'package:plo/repository/firebase_post_repository.dart';
import 'package:plo/views/postdetail_screen/other_post/post_Detail_OtherPost.dart';
import 'package:plo/views/postdetail_screen/postDetailScreen.dart';
import 'package:plo/views/postdetail_screen/postpicture.dart';
import 'package:shimmer/shimmer.dart';

final fetchUsesOtherPostProvider = FutureProvider.autoDispose
    .family<List<PostModel>?, PostModel>((ref, post) async {
  final futurePost = ref.watch(firebasePostRepository).fetchUsersSixOtherPosts(
      userUid: post.uploadUserUid, excludePostUid: post.pid);
});

class PostDetailUserOtherPostsWidget extends ConsumerWidget {
  final PostModel postKey;

  PostDetailUserOtherPostsWidget({super.key, required this.postKey});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(postDetailCurrentUserFutureProvider).when(
          data: (user) {
            if (user == null)
              return Icon(
                Icons.error_outline,
                size: 30,
              );
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return PostDetailSeeOtherPostsDetailPage(
                            userUid: postKey.uploadUserUid,
                          );
                        },
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ref
                          .watch(postUploaderProvider(postKey.uploadUserUid))
                          .when(
                            error: (error, stackTrace) => Text(
                              error.toString(),
                            ),
                            loading: () => ShimmerIndividualWidget(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey[300],
                                ),
                              ),
                            ),
                            data: (user) {
                              if (user == null)
                                return const Text("유저를 찾을 수가 없습니다");
                              return Expanded(
                                child: Text(
                                  "이 ${user.userNickname}의 다른 게시물",
                                  textAlign: TextAlign.start,
                                  maxLines: 1,
                                  style: Theme.of(context).textTheme.titleLarge,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              );
                            },
                          ),
                      const Icon(Icons.arrow_forward_ios_rounded, size: 24),
                    ],
                  ),
                ),
                Container(
                  child: ref.watch(fetchUsesOtherPostProvider(postKey)).when(
                        data: (data) {
                          if (data == null)
                            return const PostDetailUserOtherPostsErrorWidget(
                              message: "다른 게시물을 가져오는데 에러가 있었습니다.",
                            );
                          if (data.isEmpty) return const NoMorePost();
                          return GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 5,
                                      mainAxisSpacing: 5),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () async {
                                    bool proceed = true;
                                    if (data[index].showWarning) {
                                      proceed = await AlertBox
                                              .showYesOrNoAlertDialogue(
                                                  context, "정말로 진행 하시겠습니까?") ??
                                          false;
                                    }
                                    if (!proceed) return;
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return PostDetailScreen(
                                              postKey: data[index]);
                                        },
                                      ),
                                    );
                                  },
                                  child: CompactPostWidget(
                                    post: data[index],
                                    isBlockedUser: user.blockedUsers
                                        .contains(data[index].uploadUserUid),
                                  ),
                                );
                              },
                              itemCount: data.length > 6 ? 6 : data.length);
                        },
                        error: (error, stackTrace) => Text(error.toString()),
                        loading: () => GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisExtent: 6,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
                            ),
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: ShimmerIndividualWidget(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.grey[300],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Expanded(
                                    flex: 1,
                                    child: ShimmerIndividualWidget(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                            itemCount: 3),
                      ),
                ),
              ],
            );
          },
          error: (error, stackTrace) => Container(
            child: const Center(
              child: SizedBox(
                height: 30,
                width: 30,
                child: Text("예상치 못한 에러가 있었습니다"),
              ),
            ),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        );
  }
}
