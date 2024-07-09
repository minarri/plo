import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plo/common/utils/log_util.dart';
import 'package:plo/model/user_model.dart';
import 'package:plo/repository/firebase_user_repository.dart';

class UserProvider extends StateNotifier<UserModel?> {
  final Ref ref;
  UserProvider(this.ref) : super(null);

  void setUser(UserModel? user) {
    state = user;
    print(
        "currently signed in as ${user?.userNickname}. UID: ${user?.userUid}}");
  }

  Future<bool> updateUserFromFirebase() async {
    await Future.delayed(Duration(seconds: 1));
    final user = await ref.watch(firebaseUserRepository).fetchUser();
    if (user != null) {
      logToConsole("User fetched from Firebase: ${user.userNickname}");
      state = user;
    } else {
      logToConsole("No user data returned from Firebase");
    }
    return true;
  }
}

final currentUserProvider =
    StateNotifierProvider.autoDispose<UserProvider, UserModel?>((ref) {
  ref.onDispose(() {
    logToConsole("currentUserProvider disposed");
  });
  return UserProvider(ref);
});
