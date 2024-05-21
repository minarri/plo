import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plo/common/utils/log_util.dart';
import 'package:plo/model/post_model.dart';
import 'package:plo/repository/firebase_post_repository.dart';

class SinglePostProvider extends StateNotifier<PostModel> {
  final FirebasePostRepository firebasePostRepository;
  final PostModel post;
  SinglePostProvider ({
    required this.firebasePostRepository,
    required this.post,
  }) : super(post);

  updatePost(PostModel post) {
    state = post;
  }

  Future<void> updatePostFromServer() async {
    final post = await firebasePostRepository.fetchPostByPostUid(state.pid);
    if(post != null) {
      print("Updating post from Server");
      state = post;
    }
  }
}

final singlePostProvider = StateNotifierProvider.family.autoDispose<SinglePostProvider, PostModel, PostModel>((ref, post) {
  ref.onDispose(() {
    logToConsole("Single Post disposed");
  });
  return SinglePostProvider(firebasePostRepository: ref.watch(firebasePostRepository), post: post);
})