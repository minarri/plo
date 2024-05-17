import 'package:flutter_riverpod/flutter_riverpod.dart';

class TermsInfoNotifier extends StateNotifier<Map<String, bool?>> {
  TermsInfoNotifier()
      : super({
          "checkbox1": true,
          "checkbox2": true,
          "checkbox3": true,
        });

  void setCheckBoxes(bool? checkbox1,
      bool? checkbox2, bool? checkbox3) {
    state = {
      "checkbox1": checkbox1,
      "checkbox2": checkbox2,
      "checkbox3": checkbox3,
    };
  }
}

final termsInfoProvider =
    StateNotifierProvider<TermsInfoNotifier, Map<String, bool?>>(
  (ref) => TermsInfoNotifier(),
);
