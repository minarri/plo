/*

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:plo/common/widgets/custom_alert_box.dart';
import 'package:plo/common/widgets/loading_widgets/expanded_loading_post.dart';
import 'package:plo/common/widgets/loading_widgets/loading_expanded_post.dart';
import 'package:plo/common/widgets/no_more_post.dart';
import 'package:plo/common/widgets/no_post_found.dart';
import 'package:plo/model/user_model.dart';
import 'package:plo/repository/firebase_user_repository.dart';
import 'package:plo/views/home_screen/main_post_list_controller.dart';
import 'package:plo/views/home_screen/main_post_list_provider.dart';
import 'package:plo/views/postdetail_screen/postpicture.dart';

final mainPostListCurrentUserProvider =
    FutureProvider.autoDispose<UserModel?>((ref) async {
  final user = await ref.watch(firebaseUserRepository).fetchUser();
  return user;
});

class MainPostList extends ConsumerWidget {
  const MainPostList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mainpostListController);
    final posts = ref.watch(mainListProvider);

    return RefreshIndicator(
      onRefresh: () async {
        ref.refresh(mainpostListController);
        ref.refresh(mainPostListCurrentUserProvider);
      },
      child: ref.watch(mainPostListCurrentUserProvider).when(
        data: (currentUser) {
          return Container(
            padding: const EdgeInsets.all(10),
            child: state.isLoading
                ? const ExpandedPostListLoadingWidget()
                : posts.length == 0
                    ? const NoPostFound()
                    : ListView.separated(
                        physics: const AlwaysScrollableScrollPhysics(),
                        controller: ref
                            .watch(mainpostListController.notifier)
                            .scrollController,
                        itemBuilder: (context, index) {
                          if (index >= posts.length) {
                            return ref
                                    .watch(mainpostListController.notifier)
                                    .isPostAllLoaded
                                ? const NoMorePost()
                                : const LoadingExpandedPostWidget();
                          }
                          return InkWell(
                            onTap: () async {
                              if (posts.elementAt(index).showWarning) {
                                final isConfirmed =
                                    await AlertBox.showYesOrNoAlertDialogue(
                                        context, "계속 하시겠습니까?");
                                if (isConfirmed == true) {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => PostDetail(
                                        postKey: posts[index],
                                      ),
                                    ),
                                  );
                                } else {
                                  return;
                                }
                              }
                            },
                            //이거 관련해서 나중에 추가하기
                            // child: ExpandedItemWidget(
                            //         item: items.elementAt(index),
                            //         isFromBlockedUser: currentUser == null ? false : currentUser.blockedUsers.contains(items[index].uploaderUserUid),
                            //       ));
                          );
                        },
                        separatorBuilder: (context, index) => Container(),
                        itemCount: posts.length + 1,
                      ),
          );
        },
        error: (error, stackTrace) => Text("Unknow Error Occured"),
        loading: () => Center(child: const CircularProgressIndicator()),
        
      ),
    );
  }
}

*/