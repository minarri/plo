import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plo/model/comments_model.dart';

class CommentListProvider extends StateNotifier<List<CommentModel>> {
  final String pid;
  CommentListProvider({required this.pid}) : super(const []);

  _commentExistInList(CommentModel comment) {
    return state.any((commentInList) => commentInList.cid == comment.cid);
  }

  setCommentList(List<CommentModel> commentList) {
    state = commentList;
  }

  // addListenToCommentList(List<CommentModel> commentList) {
  //   state = [
  //     ...state,
  //     ...commentList.where((newComment) => !_commentExistInList(newComment))
  //   ];
  // }
  void addListenToCommentList(List<CommentModel> commentList) {
    final newComments = commentList
        .where((newComment) => !_commentExistInList(newComment))
        .toList();
    if (newComments.isNotEmpty) {
      state = [...state, ...newComments];
    }
  }

  void updateSingleCommentInCommentList(CommentModel comment) {
    if (_commentExistInList(comment)) {
      state = state
          .map((commentInList) =>
              (commentInList.cid == comment.cid) ? comment : commentInList)
          .toList();
    }
  }

  void addSingleComment(CommentModel comment) {
    state = state
        .map((commentInList) =>
            (commentInList.cid == comment.cid) ? comment : commentInList)
        .toList();

    // Append the comment if it doesn't exist
    if (!_commentExistInList(comment)) {
      state = [...state, comment];
    }
  }

  Timestamp? getLastUploadTime(CommentModel comment) {
    if (state.isEmpty) {
      return null; // No comments in the list
    } else {
      return state
          .last.uploadTime; // Return the upload time of the last comment
    }
  }
}

final commentListProvider = StateNotifierProvider.autoDispose
    .family<CommentListProvider, List<CommentModel>, String>(
        (ref, pid) => CommentListProvider(pid: pid));
