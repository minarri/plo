import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
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
  late PagingController<int, CommentModel> pagingController;

  CommentListController(
      {required this.ref,
      required this.commentRepository,
      required this.firebaseUserRepository,
      required this.pid})
      : super(const AsyncLoading()) {
    // pagingController = PagingController(firstPageKey: 0);
    // pagingController.addPageRequestListener((pageKey) {
    // });
    _setUpScrollBehavior();
    _fetchinitialcomments();
  }

  void _setUpScrollBehavior() async {
    _scrollController.addListener(() async {
      log("Current Scroll Position: ${_scrollController.position.pixels}");
      log("Max Scroll Extent: ${_scrollController.position.maxScrollExtent}");
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !_isCommentAllLoaded) {
        log('Reached the bottom of the list, fetching more comments');

        await _fetchMoreComments();
      }
    });
  }

  ScrollController get scrollController => _scrollController;
  get isCommentAllLoaded => _isCommentAllLoaded;

  // Future<void> _fetchComments(int pageKey) async {
  //   try {
  //     state = const AsyncValue.loading();
  //     final commentList = ref.read(commentListProvider(pid));
  //     Timestamp? lastUploadTime;
  //     if (pageKey > 0 && commentList.isNotEmpty) {
  //       lastUploadTime = commentList.last.uploadTime!;
  //     } else {
  //       lastUploadTime = null;
  //       log("Fetching initial comments");
  //     }
  //     // final lastUploadTime = pageKey == 0
  //     // ? null
  //     // : commentList.isEmpty
  //     //     ? commentList.last.uploadTime
  //     //     : null;

  //     List<CommentModel>? comments = await commentRepository.fetchComments(pid,
  //         amountFetch: amountFetch, lastCommentUploadTime: lastUploadTime);
  //     if (comments == null || comments.isEmpty) {
  //       pagingController.appendLastPage([]);
  //       _isCommentAllLoaded = true;
  //     } else {
  //       log("Fetched${comments.length}");
  //       ref
  //           .read(commentListProvider(pid).notifier)
  //           .addListenToCommentList(comments);

  //       final isLastPage = comments.length < amountFetch;
  //       if (isLastPage) {
  //         pagingController.appendLastPage(comments);
  //         _isCommentAllLoaded = true;
  //       } else {
  //         final nextPageKey = pageKey + comments.length;
  //         pagingController.appendPage(comments, nextPageKey);
  //       }
  //     }
  //   } catch (error) {
  //     pagingController.error = error;
  //     log("pagingController ${error}");
  //   }
  // }

  // @override
  // void dispose() {
  //   pagingController.dispose();
  //   super.dispose();
  // }

  void _fetchinitialcomments() async {
    try {
      state = const AsyncValue.loading();

      List<CommentModel>? comments =
          await commentRepository.fetchComments(pid, amountFetch: amountFetch);
      if (comments == null || comments.isEmpty) {
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
      log("last UploadTime ${lastUploadTime}");
      List<CommentModel>? comments = await commentRepository.fetchComments(pid,
          amountFetch: amountFetch, lastCommentUploadTime: lastUploadTime);
      if (comments == null || comments.isEmpty) {
        state = AsyncValue.error("댓글을 더 가져오는 도중 에러가 났습니다", StackTrace.current);
      } else {
        if (comments.length < amountFetch) {
          _isCommentAllLoaded = true;
        }
        ref
            .read(commentListProvider(pid).notifier)
            .addListenToCommentList(comments);
        log('added more comments');
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
