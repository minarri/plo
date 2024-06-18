import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plo/common/widgets/custom_alert_box.dart';
import 'package:plo/common/widgets/modal_bottomsheet/default_modal_bottom.dart';
import 'package:plo/common/widgets/modal_bottomsheet/modal_bottom_icon.dart';
import 'package:plo/model/post_model.dart';
import 'package:plo/model/state_model/create_edit_post_model.dart';
import 'package:plo/common/providers/singlepost.dart';
import 'package:plo/services/delete_service.dart';
import 'package:plo/views/post_write/post_write_screen/post_write_screen.dart';

final isDeletingPostProvider = StateProvider.autoDispose<bool>((ref) => false);

class PostDetailCurrentUserBottomSheet extends ConsumerWidget {
  final PostModel postkey;
  final BuildContext parentcontext;
  const PostDetailCurrentUserBottomSheet(
      {super.key, required this.postkey, required this.parentcontext});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final post = ref.watch(singlePostProvider(postkey));
    return DefaultModalBottomSheet(
      title: "게시물 관리",
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ModalBottomSheetIcon(
              title: "수정",
              onTap: () async {
                Navigator.of(context).pop();
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CreateEditPostScreen(
                      editPostInformation:
                          CreateEditPostModel.initForEditItem(post),
                    ),
                  ),
                );
                await ref
                    .watch(singlePostProvider(postkey).notifier)
                    .updatePostFromServer();
              },
              icon: const Icon(Icons.edit)),
          ModalBottomSheetIcon(
              title: "삭제",
              onTap: () async {
                Navigator.of(context).pop();
                final isConfirmed = await AlertBox.showYesOrNoAlertDialogue(context, "정말로 삭제하시겠습니까?");
                if(isConfirmed ?? false) {
                  ref.watch(deleteServiceProvider).deletePost(postkey);
                }
                if(isConfirmed == true) {
                  Navigator.of(context).pop();
                }
              },
              
              )
        ],
      ),
    );
  }
}
