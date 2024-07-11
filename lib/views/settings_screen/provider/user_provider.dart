import 'package:plo/model/user.dart' as model;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plo/views/settings_screen/settings_controller.dart';

class UserInfoNotifier extends StateNotifier<model.User> {
  UserInfoNotifier() : super(model.User.initial());

  void setUserdata(model.User user) {
    state = user;
  }
}

final userInfoProvider = StateNotifierProvider<UserInfoNotifier, model.User>(
  (ref) => UserInfoNotifier(),
);

final userProvider = FutureProvider<model.User>((ref) async {
  final user = await getUserData();
  ref.read(userInfoProvider.notifier).setUserdata(user);
  return user;
});



