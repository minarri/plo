import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plo/model/comments_model.dart';
import 'package:plo/model/user_model.dart';
import 'package:plo/repository/firebase_user_repository.dart';

final commentUploaderProvider =
    FutureProvider.autoDispose.family<UserModel?, String>((ref, userUid) async {
  final userFetched =
      ref.watch(firebaseUserRepositoryProvider).fetchUserbyUid(userUid);
  return userFetched;
});

final commentDetailCurrentUserFutureProvider =
    FutureProvider.autoDispose<UserModel?>((ref) async {
  final user = await ref.watch(firebaseUserRepositoryProvider).fetchUser();
  return user;
});

class CommentDetailScreen extends ConsumerWidget {
  final CommentModel commentKey;
  const CommentDetailScreen({super.key, required this.commentKey});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Text("Hello");
  }
}
