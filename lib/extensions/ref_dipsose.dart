import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

extension RefExtension on AutoDisposeStateNotifierProviderRef {
  /// Logs the dispose of the provider to the console
  void logDisposeToConsole(String message) {
    onDispose(() {
      log("$message disposed");
    });
  }
}

