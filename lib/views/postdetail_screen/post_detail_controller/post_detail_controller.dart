import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostDetailController extends StateNotifier<AsyncValue<void>> {
  Ref ref;
  PostDetailController(this.ref) : super(const AsyncValue.data(null)) {
    _init();
  }
}

_init() async {
}
