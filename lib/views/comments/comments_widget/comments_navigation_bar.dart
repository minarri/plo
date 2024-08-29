import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plo/common/providers/singlepost.dart';
import 'package:plo/model/post_model.dart';
import 'package:plo/model/state_model/create_edit_comment_model.dart';
import 'package:plo/views/comments/comments_controller.dart';
import 'package:plo/views/comments/comments_provider.dart';

class NavigationBarPostDetailScreen extends ConsumerStatefulWidget {
  final CreateEditCommentModel? editCommentInformation;
  final PostModel postKey;
  const NavigationBarPostDetailScreen(
      {super.key, this.editCommentInformation, required this.postKey});

  @override
  ConsumerState<NavigationBarPostDetailScreen> createState() =>
      _NavigationBarPostDetailScreenState();
}

class _NavigationBarPostDetailScreenState
    extends ConsumerState<NavigationBarPostDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.editCommentInformation != null) {
        ref
            .watch(createEditCommentController.notifier)
            .initFieldForEdit(widget.editCommentInformation!);
        ref
            .watch(createEditCommentStateProvider.notifier)
            .initForEdit(widget.editCommentInformation!);
      }
    });
  }

  Widget build(BuildContext context) {
    return Container();
  }
}
