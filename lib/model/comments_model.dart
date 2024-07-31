import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plo/constants/error_replacement_constants.dart';

class CommentModelFieldNameConstants {
  static const cid = "cid";
  static const commentContent = "commentContent";
  static const profileImageUrl = "profileImageUrl";
  static const commentsUserNickname = "commentsUserNickname";
  static const commentsUserUid = "commentsUserUid";
  static const uploadTime = "uploadTime";
  static const commentsPid = "commentsPid";
  static const commentLikes = "commentLikes";
  static const showWarning = "showWarning";
  static const subComment = "subComment";
}

class CommentModel {
  final String cid;
  final String commentContent;
  final String profileImageUrl;
  final String commentsUserNickname;
  final String commentsUserUid;
  final Timestamp? uploadTime;
  final String commentsPid;
  final int commentLikes;
  final bool showWarning;
  final List<CommentModel> subComment;

  CommentModel({
    this.cid = ErrorReplacementConstants.notSetString,
    this.commentContent = ErrorReplacementConstants.notSetString,
    this.profileImageUrl = ErrorReplacementConstants.notSetString,
    this.commentsUserNickname = ErrorReplacementConstants.notSetString,
    this.commentsUserUid = ErrorReplacementConstants.notSetString,
    this.uploadTime,
    this.commentsPid = ErrorReplacementConstants.notSetString,
    this.commentLikes = 0,
    this.showWarning = false,
    this.subComment = const [],
  });

  Map<String, Object?> toJson() {
    return {
      CommentModelFieldNameConstants.cid: cid,
      CommentModelFieldNameConstants.commentContent: commentContent,
      CommentModelFieldNameConstants.profileImageUrl: profileImageUrl,
      CommentModelFieldNameConstants.commentsUserNickname: commentsUserNickname,
      CommentModelFieldNameConstants.uploadTime: uploadTime,
      CommentModelFieldNameConstants.commentsPid: commentsPid,
      CommentModelFieldNameConstants.commentLikes: commentLikes,
      CommentModelFieldNameConstants.showWarning: showWarning,
      CommentModelFieldNameConstants.subComment:
          subComment.map((e) => e.toJson()).toList(),
    };
  }

  static CommentModel? fromJson(Map<String, dynamic> json) {
    try {
      final List<CommentModel> convertedSubComment =
          json[CommentModelFieldNameConstants.subComment] == null
              ? const []
              : (json[CommentModelFieldNameConstants.subComment]
                      as List<dynamic>)
                  .map((e) => CommentModel.fromJson(e as Map<String, dynamic>)!)
                  .toList();
      return CommentModel(
        cid: json[CommentModelFieldNameConstants.cid] ??
            ErrorReplacementConstants.notFoundString,
        commentContent: json[CommentModelFieldNameConstants.commentContent] ??
            ErrorReplacementConstants.notFoundString,
        profileImageUrl: json[CommentModelFieldNameConstants.profileImageUrl] ??
            ErrorReplacementConstants.notFoundString,
        commentsUserNickname:
            json[CommentModelFieldNameConstants.commentsUserNickname] ??
                ErrorReplacementConstants.notFoundString,
        uploadTime: json[CommentModelFieldNameConstants.uploadTime],
        commentsPid: json[CommentModelFieldNameConstants.commentsPid] ??
            ErrorReplacementConstants.notFoundString,
        commentLikes: json[CommentModelFieldNameConstants.commentLikes] ?? 0,
        showWarning: json[CommentModelFieldNameConstants.showWarning] ?? false,
        subComment: convertedSubComment,
      );
    } catch (error) {
      log("There has been an error while transforming model from server to fromJson ${error.toString()}");
      return null;
    }
  }

  CommentModel update({
    String? cid,
    String? commentContent,
    String? profileImageUrl,
    String? commentsUserNickname,
    Timestamp? uploadTime,
    String? commentsPid,
    int? commentLikes,
    bool? showWarning,
    List<CommentModel>? subComment,
  }) {
    return CommentModel(
      cid: cid ?? this.cid,
      commentContent: commentContent ?? this.commentContent,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      commentsUserNickname: commentsUserNickname ?? this.commentsUserNickname,
      uploadTime: uploadTime ?? this.uploadTime,
      commentsPid: commentsPid ?? this.commentsPid,
      commentLikes: commentLikes ?? this.commentLikes,
      showWarning: showWarning ?? this.showWarning,
      subComment: subComment ?? this.subComment,
    );
  }
}
