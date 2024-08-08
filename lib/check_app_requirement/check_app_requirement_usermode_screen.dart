import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plo/check_app_requirement/check_app_requirement_screen.dart';
import 'package:plo/repository/firebase_user_repository.dart';
import 'package:plo/views/sign_up_screen_view/sign_up_screen.dart';

// final isEmailVerifiedProvider = StateProvider.autoDispose<bool>(
//     (ref) => FirebaseAuth.instance.currentUser!.emailVerified);
final isUserModelSetupProvider = FutureProvider.autoDispose((ref) async {
  final user = await ref.watch(firebaseUserRepositoryProvider).currentUser;
  if (user == null) {
    return false;
  } else {
    return true;
  }
});

class CheckEmailAndUsermodelScreen extends ConsumerStatefulWidget {
  const CheckEmailAndUsermodelScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CheckEmailAndUsermodelScreenState();
}

class _CheckEmailAndUsermodelScreenState
    extends ConsumerState<CheckEmailAndUsermodelScreen> {
  @override
  Widget build(BuildContext context) {
    // final isEmailVerified = ref.watch(isEmailVerifiedProvider);
    final isUserModelSetup = ref.watch(isUserModelSetupProvider);
    // if (isEmailVerified == false) return const EmailVerificationScreen();
    return isUserModelSetup.when(
      error: (error, stackTrace) => const Scaffold(
        body: Center(
          child: Text(
            "Unknow error occured. Please try again later.",
          ),
        ),
      ),
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      data: (data) {
        return data == false
            ? SignUpScreen()
            : const CheckAppRequirementScreen();
      },
    );
  }
}
