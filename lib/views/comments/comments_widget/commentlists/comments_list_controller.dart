import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plo/common/providers/singlepost.dart';
import 'package:plo/model/comments_model.dart';
import 'package:plo/model/post_model.dart';
import 'package:plo/repository/firebase_comments_repository.dart';
import 'package:plo/repository/firebase_user_repository.dart';
import 'package:plo/views/comments/comments_widget/commentlists/comments_list_provider.dart';

class CommentListController extends StateNotifier<AsyncValue<void>> {
  final int amountFetch = 10;
  bool _isCommentAllLoaded = false;
  final _scrollController = ScrollController();
  Ref ref;
  final CommentsRepository commentRepository;
  final FirebaseUserRepository firebaseUserRepository;
  final String pid;

  CommentListController(
      {required this.ref,
      required this.commentRepository,
      required this.firebaseUserRepository,
      required this.pid})
      : super(const AsyncLoading()) {
    _setUpScrollBehavior();
    _fetchinitialcomments();
  }

  void _setUpScrollBehavior() async {
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !_isCommentAllLoaded) {
        await _fetchMoreComments();
      }
      log("fetched posts");
    });
  }

  get scrollController => _scrollController;
  get isCommentAllLoaded => _isCommentAllLoaded;

  void _fetchinitialcomments() async {
    try {
      state = const AsyncValue.loading();

      List<CommentModel>? comments =
          await commentRepository.fetchComments(pid, amountFetch: amountFetch);
      if (comments == null) {
        state = AsyncValue.error("댓글을 가져오는 도중 에러가 났습니다", StackTrace.current);
        return;
      }
      if (comments.length < amountFetch) _isCommentAllLoaded = true;
      ref.read(commentListProvider(pid).notifier).setCommentList(comments);
    } catch (error) {
      state = AsyncValue.error(error, StackTrace.current);
    } finally {
      state = const AsyncValue.data(null);
    }
  }

  Future<void> _fetchMoreComments() async {
    try {
      final lastUploadTime =
          ref.read(commentListProvider(pid)).last.uploadTime!;
      List<CommentModel>? comments = await commentRepository.fetchComments(pid,
          amountFetch: amountFetch, lastCommentUploadTime: lastUploadTime);
      if (comments == null) {
        state = AsyncValue.error("댓글을 더 가져오는 도중 에러가 났습니다", StackTrace.current);
      } else {
        if (comments.length < amountFetch) {
          _isCommentAllLoaded = true;
        }
        ref
            .read(commentListProvider(pid).notifier)
            .addListenToCommentList(comments);
      }
    } catch (error) {
      state = AsyncValue.error(error, StackTrace.current);
      state = const AsyncValue.data(null);
    } finally {
      state = const AsyncValue.data(null);
    }
  }
}

final commentListController = StateNotifierProvider.autoDispose
    .family<CommentListController, AsyncValue<void>, String>((ref, pid) {
  final commentRepository = ref.watch(firebaseCommentRepository);
  final userRepository = ref.watch(firebaseUserRepositoryProvider);
  // final post = PostModel();
  return CommentListController(
      ref: ref,
      commentRepository: commentRepository,
      firebaseUserRepository: userRepository,
      pid: pid);
});
