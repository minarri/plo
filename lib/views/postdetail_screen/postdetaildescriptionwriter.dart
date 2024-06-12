import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plo/common/utils/functions.dart';
import 'package:plo/model/post_model.dart';
import 'package:plo/model/types/category_type.dart';
import 'package:plo/providers/singlepost.dart';

class PostDetailDescriptionWriterWidget extends ConsumerStatefulWidget {
  final PostModel postKey;
  const PostDetailDescriptionWriterWidget({super.key, required this.postKey});
  @override
  ConsumerState<PostDetailDescriptionWriterWidget> createState() =>
      _PostDetailDescriptionWriteWidgetState();
}

class _PostDetailDescriptionWriteWidgetState
    extends ConsumerState<PostDetailDescriptionWriterWidget> {
  String selectedStatus = 'Information';
  @override
  Widget build(BuildContext context) {
    final post = ref.watch(singlePostProvider(widget.postKey));

    return Container(
        height: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Text("${post.category}",
                  style: const TextStyle(
                      fontSize: 33, fontWeight: FontWeight.bold)),
              Tooltip(
                  message: post.category == CategoryType.information
                      ? "Information"
                      : "General",
                  preferBelow: false,
                  triggerMode: TooltipTriggerMode.longPress,
                  showDuration: const Duration(seconds: 3),
                  waitDuration: Duration.zero,
                  child: post.category == CategoryType.information
                      ? const Icon(Icons.info_outline)
                      : const Icon(Icons.category)),
              const Spacer(),
              SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text(
                    "${post.userNickname} * ${Functions.timeDifferenceInText(DateTime.now().difference(post.uploadTime!.toDate()))}",
                    style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 20),
                Expanded(
                  child: Text(
                    "${post.postContent}",
                    style: TextStyle(fontSize: 19),
                  ),
                )
              ])
            ])
          ],
        ));
  }
}
