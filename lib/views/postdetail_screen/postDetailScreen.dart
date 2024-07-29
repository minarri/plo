import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plo/common/providers/singlepost.dart';
import 'package:plo/common/widgets/detail_no_like_button.dart';
import 'package:plo/model/post_model.dart';
import 'package:plo/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:plo/repository/firebase_user_repository.dart';
import 'package:plo/views/post_write/user_provider/user_provider.dart';
import 'package:plo/views/postdetail_screen/homescreenbuttonwidget.dart';
import 'package:plo/views/postdetail_screen/other_post/postdetailuserotherposts.dart';
import 'package:plo/views/postdetail_screen/post_detail_controller/post_detail_controller.dart';
import 'package:plo/views/postdetail_screen/post_like_button.dart';
import 'package:plo/views/postdetail_screen/postdetailProfile.dart';
import 'package:plo/views/postdetail_screen/postdetaildescription.dart';
import 'package:plo/views/postdetail_screen/postdetailsamecategory.dart';
import 'package:plo/views/postdetail_screen/postpicture.dart';
import 'package:plo/views/settings_screen/provider/non_login_provider.dart';

final postUploaderProvider =
    FutureProvider.autoDispose.family<UserModel?, String>((ref, userUid) async {
  final userFetched =
      await ref.watch(firebaseUserRepositoryProvider).fetchUserbyUid(userUid);
  return userFetched;
});

final postDetailCurrentUserFutureProvider =
    FutureProvider.autoDispose<UserModel?>((ref) async {
  final user = await ref.watch(firebaseUserRepositoryProvider).fetchUser();
  return user;
});

class PostDetailScreen extends ConsumerWidget {
  final PostModel postKey;
  const PostDetailScreen({super.key, required this.postKey});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(postDetailControllerProvider.notifier).updateViewCounts(postKey);

    final state = ref.watch(postDetailControllerProvider);
    final isNotSignedUser = ref.watch(proceedWithoutLoginProvider);
    final user = ref.watch(currentUserProvider);
    final isMyPost = ref.watch(proceedWithoutLoginProvider)
        ? false
        : postKey.uploadUserUid == user!.userUid;
    final post = ref.watch(singlePostProvider(postKey));

    return ref.watch(postUploaderProvider(post.uploadUserUid)).when(
        data: (data) {
          return state.isLoading
              ? const Scaffold(
                  body: Center(
                  child: CircularProgressIndicator(),
                ))
              : Material(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: SafeArea(
                    child: Scaffold(
                      extendBodyBehindAppBar: true,
                      appBar: AppBar(
                        automaticallyImplyLeading: false,
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                        actions: [
                          PostFloatingButton(
                              postKey: postKey, parentContext: context)
                        ],
                      ),
                      body: Stack(
                        children: [
                          SingleChildScrollView(
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 50),
                                  PostDetailProfileWidget(
                                    postKey: postKey,
                                  ),
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: PostDetailWidget(
                                      postKey: postKey,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: isNotSignedUser
                                          ? DetailNoLikeButton()
                                          : SizedBox(
                                              child: PostDetailLikeButton(
                                                postKey: postKey,
                                              ),
                                            ),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  // PostDetailPhoto(postKey: postKey),
                                  const Divider(
                                    thickness: 1,
                                  ),
                                  if (!isMyPost)
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: PostDetailUserOtherPostsWidget(
                                        postKey: postKey,
                                      ),
                                    ),
                                  if (!isMyPost)
                                    Divider(
                                      thickness: 1,
                                    ),
                                  if (!isMyPost) ...[
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: PostDetailSameCategoryWidget(
                                        postKey: postKey,
                                      ),
                                    ),
                                    Divider(
                                      thickness: 1,
                                    )
                                  ],
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ));
        },
        error: (error, stackTrace) => const Icon(Icons.error_outline),
        loading: () => const CircularProgressIndicator());
  }
}
