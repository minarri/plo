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

  addListenToCommentList(List<CommentModel> commentList) {
    state = [...state, ...commentList];
  }

  updateSingleCommentInCommentList(CommentModel comment) {
    if (_commentExistInList(comment)) {
      state = state
          .map((commentInList) =>
              (commentInList.cid == comment.cid) ? comment : commentInList)
          .toList();
    }
  }

  void addSingleComment(CommentModel comment) {
    if (!_commentExistInList(comment)) {
      state = state
          .map((commentInList) =>
              (commentInList.cid == comment.cid) ? comment : commentInList)
          .toList();
    }
  }
}

final commentListProvider = StateNotifierProvider.autoDispose
    .family<CommentListProvider, List<CommentModel>, String>(
        (ref, pid) => CommentListProvider(pid: pid));
