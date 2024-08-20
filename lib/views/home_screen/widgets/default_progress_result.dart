import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plo/common/widgets/custom_button.dart';
import 'package:plo/model/types/return_type.dart';
import 'package:plo/views/home_screen/home_screen.dart';

final futureFunctionProvider =
    FutureProvider.autoDispose.family<dynamic, Future>((ref, future) async {
  return await future;
});

class DefaultProgressResult extends ConsumerStatefulWidget {
  final Future future;
  const DefaultProgressResult({super.key, required this.future});
  @override
  ConsumerState<DefaultProgressResult> createState() =>
      _DefaultProgressResultState();
}

class _DefaultProgressResultState extends ConsumerState<DefaultProgressResult> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (!didPop) {
          print("Pop was blocked");
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: ref.watch(futureFunctionProvider(widget.future)).when(
              error: (error, stackTrace) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "에러가 발생했습니다. ${error.toString()}",
                  textAlign: TextAlign.center,
                ),
                FittedBox(
                  child: Text(
                    "다음에 다시 시도해주시거나 저희에게 연락 주세요!",
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            );
          }, loading: () {
            return const SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: CircularProgressIndicator()),
                  SizedBox(height: 10),
                  FittedBox(
                    child: Text(
                      "현재 요청하신 사항을 처리 중입니다!",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Text(
                    "조그만 기다려주세요!",
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            );
          }, data: (data) {
            final isSuccess =
                data is SuccessReturnType && data.isSuccess == true;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                FittedBox(
                  child: Text(
                    isSuccess ? "요청하신 사항이 성공적으로 완료 되었습니다" : "요청하신 사항이 실패하였습니다.",
                    textAlign: TextAlign.center,
                  ),
                ),
                if (!isSuccess) ...[
                  const SizedBox(
                    height: 10,
                  ),
                  const FittedBox(
                    child: Text(
                      "다시 한번 시도해주세요 문제가 고쳐지지 않으면 문의 해주세요",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
                const Spacer(),
                CustomButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()),
                          (Route<dynamic> route) => false);
                    },
                    text: "홈 화면으로 가기")
              ],
            );
          }),
        ),
      ),
    );
  }
}
