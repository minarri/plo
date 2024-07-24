import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plo/common/widgets/custom_button.dart';
import 'package:plo/common/widgets/profile_circular_image.dart';
import 'package:plo/model/user_model.dart';
import 'package:plo/views/postdetail_screen/block_user/block_user_modal_bottomsheet.dart';

class BlockedUserModalBottomSheetBlockPage extends ConsumerWidget {
  final UserModel currentUser;
  final UserModel blockingUser;
  final bool isBlocked;
  const BlockedUserModalBottomSheetBlockPage(
      {super.key,
      required this.currentUser,
      required this.blockingUser,
      required this.isBlocked});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DefaultProfileImageWidget(
            imageUrl: blockingUser.profileImageUrl,
            radius: 50,
          ),
          const SizedBox(height: 10),
          FittedBox(
            child: Text("정말 차단 하시겠습니까? ${isBlocked ? "차단" : "아니요"}",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium),
          ),
          FittedBox(child: Text("${blockingUser.userNickname}?")),
          const SizedBox(
            height: 10,
          ),
          FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(isBlocked
                  ? "이 유저의 정보가 더 이상 보이지 않습니다"
                  : "이 유저의 게시물을 계속 볼 수 있습니다")),
          CustomButton(
              text: isBlocked ? "차단" : "아니요",
              onPressed: () {
                ref
                        .watch(blockedUserModalBottomSheetIsBlockPressedProvider
                            .notifier)
                        .state ==
                    true;
              })
        ],
      ),
    );
  }
}
