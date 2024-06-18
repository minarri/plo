import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plo/common/utils/functions.dart';
import 'package:plo/model/post_model.dart';
import 'package:plo/model/types/category_type.dart';
import 'package:plo/common/providers/singlepost.dart';
import 'package:plo/views/post_write/user_provider/user_provider.dart';
import 'package:plo/views/settings_screen/provider/non_login_provider.dart';

class PostDetailWidget extends ConsumerStatefulWidget {
  final PostModel postKey;
  PostDetailWidget({super.key, required this.postKey});

  @override
  ConsumerState<PostDetailWidget> createState() => _PostDetailWidgetState();
}

class _PostDetailWidgetState extends ConsumerState<PostDetailWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final post = ref.watch(singlePostProvider(widget.postKey));
    final currentUser = ref.watch(currentUserProvider);
    final isNotSignedUser = ref.watch(proceedWithoutLoginProvider);
    return Column(
      children: [
        Container(
          constraints: BoxConstraints(
            minHeight: 300,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  children: [
                    Expanded(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                          Text(
                            "${post.postTitle}",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(fontSize: 40),
                          ),
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
                        ]),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10),
              Row(children: [
                Expanded(
                  child: FittedBox(
                    alignment: Alignment.centerLeft,
                    fit: BoxFit.scaleDown,
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: "${post.category}",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    fontSize: 14,
                                    color: Colors.grey,
                                    decoration: TextDecoration.underline),
                          ),
                          TextSpan(
                              text:
                                  "${post.userNickname} *  ${Functions.timeDifferenceInText(DateTime.now().difference(post.uploadTime!.toDate()))}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(fontSize: 14, color: Colors.grey))
                        ],
                      ),
                    ),
                  ),
                )
              ]),
              SizedBox(height: 20)
            ],
          ),
        ),
        SizedBox(height: 20),
        Text("${post.postContent}",
            style: Theme.of(context).textTheme.bodyLarge),
       
      ],
    );
  }
}
