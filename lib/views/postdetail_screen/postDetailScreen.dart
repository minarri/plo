import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plo/model/post_model.dart';
import 'package:plo/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:plo/repository/firebase_user_repository.dart';

final postUplaoderProvider =
    FutureProvider.autoDispose.family<UserModel?, String>((ref, userUid) async {
  final userfetched =
      await ref.watch(firebaseUserRepository).fetchUserbyUid(userUid);
  return userfetched;
});

final postDetailCurrentUserFutureProvider =
    FutureProvider.autoDispose<UserModel?>((ref) async {
  final user = ref.watch(firebaseUserRepository).fetchUser();
  return user;
});

class PostDetailScreen extends ConsumerWidget {
  final PostModel postKey;
  const PostDetailScreen({super.key, required this.postKey});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(body: Text("Hello"));
  }
}
