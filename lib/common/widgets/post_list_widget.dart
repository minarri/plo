import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plo/model/post_model.dart';
import 'package:plo/views/home_screen/widgets/expanded_post.dart';

import '../../model/user_model.dart';
import '../../repository/firebase_user_repository.dart';
import '../../views/postdetail_screen/postDetailScreen.dart';
import 'custom_alert_box.dart';
import 'no_post_found.dart';

final postListCurrentUserFutureProvider = FutureProvider.autoDispose<UserModel?>((ref) async {
  final user = await ref.watch(firebaseUserRepositoryProvider).fetchUser();
  return user;
});

class PostListWidget extends ConsumerWidget {
  List<PostModel> posts;
  final VoidCallback refreshFunction;

  PostListWidget({
    super.key,
    required this.posts,
    required this.refreshFunction,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(postListCurrentUserFutureProvider).when(
          data: (user) {
            return RefreshIndicator(
              onRefresh: () async {
                refreshFunction();
                ref.refresh(postListCurrentUserFutureProvider);
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                child: posts.isEmpty
                    ? const NoPostFound()
                    : ListView.separated(
                        shrinkWrap: true,
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          final post = posts[index];
                          return InkWell(
                            onTap: () async {
                              bool? isConfirmed = true;
                              if (posts.elementAt(index).showWarning) {
                                isConfirmed = await AlertBox.showYesOrNoAlertDialogue(context, "계속 하시겠습니까?");
                              }
                              if (isConfirmed == true) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => PostDetailScreen(
                                      postKey: posts[index],
                                    ),
                                  ),
                                );
                              } else {
                                return;
                              }
                              refreshFunction();
                            },
                            child: ExpandedPostWidget(
                              isFromBlockedUser: user == null ? false : user.blockedUsers.contains(post.uploadUserUid),
                              post: post,
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => Container(),
                      ),
              ),
            );
          },
          error: (error, stackTrace) => const Text("Unknow Error Occured"),
          loading: () => const SizedBox(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
  }
}
