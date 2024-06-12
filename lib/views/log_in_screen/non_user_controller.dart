import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plo/repository/auth_repository.dart';

class NonUserLoginController extends StateNotifier<AsyncValue<void>> {
  final Ref ref;
  NonUserLoginController(this.ref) : super(const AsyncValue.data(null));

  Future<String> nonUserLogin() async {
    final result = await ref
        .watch(authRepository)
        .//signiInUserWithEmail();
    return result;
  }
}

final nonUserController = StateNotifierProvider.autoDispose<
    NonUserLoginController,
    AsyncValue<void>>((ref) => NonUserLoginController(ref));
