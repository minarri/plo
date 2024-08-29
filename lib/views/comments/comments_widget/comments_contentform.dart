import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plo/common/validator/validator.dart';
import 'package:plo/views/comments/comments_controller.dart';
import 'package:plo/views/comments/comments_provider.dart';

class CommentContentForm extends ConsumerWidget {
  final GlobalKey<FormState> formKey;
  const CommentContentForm({
    super.key,
    required this.formKey,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Form(
          key: formKey,
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: ref
                      .read(createEditCommentController.notifier)
                      .commentContentController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      hintText: "댓글내용"),
                  maxLength: 100,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  validator: (value) {
                    return Validator.commentContentValidator(value);
                  },
                  // onChanged: (value) {
                  //   ref
                  //       .read(createEditCommentStateProvider.notifier)
                  //       .updateContent(value);
                  // },

                  onTapOutside: (event) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                ),
              ]),
        ),
      ),
    );
  }
}
