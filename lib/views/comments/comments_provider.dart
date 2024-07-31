import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plo/model/comments_model.dart';
import 'package:plo/model/state_model/create_edit_comment_model.dart';

final createEditCommentStateProvider = StateNotifierProvider.autoDispose<
    CreateEditCommentStateNotifier, CreateEditCommentModel>((ref) {
  return CreateEditCommentStateNotifier();
});

final createEditCommentStateProviderFamily = StateNotifierProvider.autoDispose
    .family<CreateEditCommentStateNotifier, CreateEditCommentModel,
        CreateEditCommentModel?>((ref, editCommentInformation) {
  return CreateEditCommentStateNotifier(
      editInformation: editCommentInformation);
});

class CreateEditCommentStateNotifier
    extends StateNotifier<CreateEditCommentModel> {
  CreateEditCommentModel? editInformation;
  CreateEditCommentStateNotifier({this.editInformation})
      : super(CreateEditCommentModel()) {
    if (editInformation != null) {
      state = editInformation!;
    }
  }

  initForEdit(CreateEditCommentModel editCommentInformation) {
    state = editCommentInformation;
  }

  void setState(CreateEditCommentModel newState) {
    state = newState;
  }

  void updateContent(String commentContent) {
    state = state.update(commentContent: commentContent);
  }

  void updateIsSubComment(bool isSubComment) {
    state = state.update(isSubComment: isSubComment);
  }

  void updateParentComment(CommentModel? parentComment) {
    state = state.update(parentComment: parentComment);
  }
}
