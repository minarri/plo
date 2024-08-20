import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plo/common/validator/validator.dart';
import 'package:plo/common/widgets/custom_text_input_box.dart';
import 'package:plo/views/log_in_screen/log_in_controller.dart';

final passwordVisibleProvider = StateProvider<bool>((ref) => false);

class LogInTextFieldWidget extends ConsumerWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  const LogInTextFieldWidget(
      {super.key,
      required this.formKey,
      required this.emailController,
      required this.passwordController});
  static const defaultSpacing = SizedBox(height: 10);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool passwordVisible = ref.watch(passwordVisibleProvider);
    return Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            defaultSpacing,
            // TextFormField(
            //     controller: ref.watch(loginController.notifier).emailController,
            //     autofocus: true,
            //     validator: (value) => Validator.validatePSUEmail(value),
            //     keyboardType: TextInputType.emailAddress,
            //     decoration: InputDecoration(
            //       focusedBorder: OutlineInputBorder(
            //           borderSide: const BorderSide(color: Colors.black),
            //           borderRadius: BorderRadius.circular(10)),
            //       enabledBorder: OutlineInputBorder(
            //           borderSide: const BorderSide(color: Colors.grey),
            //           borderRadius: BorderRadius.circular(10)),
            //       hintText: 'abc1234@psu.edu',
            //     ),
            //     onChanged: (text) {}),
            textInputBox(
                text: "이메일",
                controller: ref.watch(loginController.notifier).emailController,
                validator: (value) => Validator.validatePSUEmail(value),
                hintText: "abc1234@psu.edu"),
            const SizedBox(height: 25),
            defaultSpacing,
            passwordInputBox(
                text: "비밀번호",
                controller:
                    ref.watch(loginController.notifier).passwordController,
                passwordVisible: passwordVisible,
                onPressed: () {
                  ref.read(passwordVisibleProvider.notifier).state =
                      !passwordVisible;
                },
                validator: (value) => Validator.validatePassword(value)),
          ],
        ));
  }
}
