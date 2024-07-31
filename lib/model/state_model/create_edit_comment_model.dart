import 'package:plo/model/comments_model.dart';

class CreateEditCommentModel {
  String commentContent;
  bool isForEdit;
  CommentModel? editCommentInformation;
  bool isSubComment;
  CommentModel? parentComment;

  CreateEditCommentModel(
      {this.commentContent = "",
      this.isForEdit = false,
      this.editCommentInformation,
      this.isSubComment = false,
      this.parentComment});

  static CreateEditCommentModel initForEditComment(
      CommentModel editCommentInformation,
      {bool isSubComment = false,
      CommentModel? parentComment}) {
    return CreateEditCommentModel(
        commentContent: editCommentInformation.commentContent,
        isForEdit: true,
        editCommentInformation: editCommentInformation,
        isSubComment: isSubComment,
        parentComment: parentComment);
  }

  CreateEditCommentModel update(
      {String? commentContent,
      bool? isForEdit,
      CommentModel? commentForEdit,
      bool? isSubComment,
      CommentModel? parentComment}) {
    return CreateEditCommentModel(
      commentContent: commentContent ?? this.commentContent,
      isForEdit: isForEdit ?? this.isForEdit,
      editCommentInformation: commentForEdit ?? editCommentInformation,
      isSubComment: isSubComment ?? this.isSubComment,
      parentComment: parentComment ?? this.parentComment,
    );
  }
}
