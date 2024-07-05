import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plo/common/widgets/custom_button.dart';
import 'package:plo/views/postdetail_screen/block_user/block_user_modal_bottomsheet.dart';

class BlockUserModalBottomSheetResultScreen extends ConsumerWidget {
  final String blockingUserUid;
  final bool isBlocked;
  const BlockUserModalBottomSheetResultScreen(
      {super.key, required this.blockingUserUid, required this.isBlocked});

  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: ref
          .watch(blockUserBottomSheetBlockUserFutureProvider(blockingUserUid))
          .when(
              data: (data) {
                return Column(
                  children: [
                    const Spacer(),
                    FittedBox(
                      child: Text(isBlocked ? "성공적으로 차단하셨습니다" : "차단하지 않으셨습니다",
                          style: Theme.of(context).textTheme.titleLarge),
                    ),
                    const Spacer(),
                    CustomButton(
                        text: "닫기",
                        onPressed: () {
                          Navigator.of(context).pop();
                        })
                  ],
                );
              },
              error: (error, stackTrace) =>
                  const Icon(Icons.error_outline_outlined, size: 30),
              loading: () => const CircularProgressIndicator()),
    );
  }
}
