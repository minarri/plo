import 'package:plo/model/post_model.dart';
import 'package:plo/repository/firebase_post_repository.dart';
import 'package:plo/repository/firebase_user_repository.dart';
import 'package:plo/views/home_screen/main_post_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainPostListController extends StateNotifier<AsyncValue<void>> {
  final int amountFetch = 10;
  final _scrollController = ScrollController();
  bool _isPostAllLoaded = false;
  Ref ref;
  final FirebasePostRepository postRepository;
  final FirebaseUserRepository userRepository;
  MainPostListController(
      {required this.ref,
      required this.postRepository,
      required this.userRepository})
      : super(const AsyncLoading()) {
    _setUpSrollBehavior();
    _fetchInitialPosts();
  }
  _setUpSrollBehavior() async {
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !_isPostAllLoaded) {
        await _fetchMorePosts();
      }
    });
  }

  get scrollController => _scrollController;
  get isPostAllLoaded => _isPostAllLoaded;

  void _fetchInitialPosts() async {
    try {
      state = const AsyncValue.loading();

      List<PostModel>? posts =
          await postRepository.fetchPost(amountFetch: amountFetch);
      if (posts == null) {
        state = AsyncValue.error("게시물을 가져오는데 실패 했습니다", StackTrace.current);
        return;
      }
      if (posts.length < amountFetch) _isPostAllLoaded = true;
      ref.read(mainPostListProvider.notifier).setPostList(posts);
    } catch (error) {
      state = AsyncValue.error(error, StackTrace.current);
    } finally {
      state = const AsyncValue.data(null);
    }
  }

  Future<void> _fetchMorePosts() async {
    try {
      final lastPostUploadTime =
          ref.read(mainPostListProvider).last.uploadTime!;
      List<PostModel>? posts = await postRepository.fetchPost(
          lastPostUploadTime: lastPostUploadTime, amountFetch: amountFetch);
      if (posts == null) {
        state = AsyncValue.error("게시물을 가져오는데 문제가 발생 했습니다", StackTrace.current);
      } else {
        if (posts.length < amountFetch) {
          _isPostAllLoaded = true;
        }
        ref.read(mainPostListProvider.notifier).addListenToPostList(posts);
      }
    } catch (error) {
      state = AsyncValue.error(error, StackTrace.current);
      state = const AsyncValue.data(null);
    } finally {
      state = const AsyncValue.data(null);
    }
  }
}

final mainpostListController =
    StateNotifierProvider.autoDispose<MainPostListController, AsyncValue<void>>(
        (ref) {
  final postRepository = ref.watch(firebasePostRepository);
  final userRepository = ref.watch(firebaseUserRepository);
  return MainPostListController(
      ref: ref, postRepository: postRepository, userRepository: userRepository);
});
