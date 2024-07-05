import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plo/common/providers/singlepost.dart';
import 'package:plo/common/widgets/custom_button.dart';
import 'package:plo/common/widgets/modal_bottomsheet/default_modal_bottom.dart';
import 'package:plo/model/post_model.dart';
import 'package:plo/views/post_write/user_provider/user_provider.dart';
import 'package:plo/views/postdetail_screen/currentUserBottomSheet.dart';
import 'package:plo/views/postdetail_screen/otherUserBottomSheet.dart';

class PostDetailButtonsWidget extends ConsumerWidget {
  final PostModel postKey;
  final BuildContext parentContext;
  const PostDetailButtonsWidget(
      {super.key, required this.postKey, required this.parentContext});

  Widget build(BuildContext context, WidgetRef ref) {
    final post = ref.watch(singlePostProvider(postKey));
    final user = ref.watch(currentUserProvider);

    return Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  user!.userUid == post.uploadUserUid
                      ? showModalBottomSheet(
                          context: context,
                          builder: (context) =>
                              PostDetailCurrentUserBottomSheet(
                                  postkey: postKey,
                                  parentcontext: parentContext))
                      : showModalBottomSheet(
                          context: context,
                          builder: (context) =>
                              PostDetailOtherUserBottomSheet(postKey: postKey));
                })
          ],
        ));
  }
}
