import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

class LoadingExpandedCommentsWidget extends ConsumerWidget {
  const LoadingExpandedCommentsWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        height: 30,
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Shimmer.fromColors(
                  baseColor: Colors.grey[200]!,
                  highlightColor: Colors.grey[50]!,
                  child: Container(
                      decoration: BoxDecoration(color: Colors.grey[200]))),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Shimmer.fromColors(
                        baseColor: Colors.grey[200]!,
                        highlightColor: Colors.grey[50]!,
                        child: Container(
                          decoration: BoxDecoration(color: Colors.grey[200]!),
                        )),
                  ),
                  const SizedBox(height: 5),
                  Expanded(
                    child: SizedBox(
                      width: 100,
                      child: Shimmer.fromColors(
                          baseColor: Colors.grey[200]!,
                          highlightColor: Colors.grey[50]!,
                          child: Container(
                            decoration: BoxDecoration(color: Colors.grey[200]!),
                          )),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Expanded(
                    child: Shimmer.fromColors(
                        baseColor: Colors.grey[200]!,
                        highlightColor: Colors.grey[50]!,
                        child: Container(
                          decoration: BoxDecoration(color: Colors.grey[200]!),
                        )),
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            )
          ],
        ));
  }
}
