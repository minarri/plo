import 'package:plo/repository/firebase_auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

final isUserLoggedinProvider = StateProvider<bool>((ref) {
  final user = ref.watch(firebaseAuthRepositoryProvider).getCurrentUser();
  if (user == null) {
    return false;
  }
  return true;
});
final proceedWithoutLoginProvider = StateProvider<bool>((ref) => false);