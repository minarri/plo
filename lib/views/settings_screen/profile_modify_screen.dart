import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plo/common/validator/validator.dart';
import 'package:plo/common/widgets/custom_app_bar.dart';
import 'package:plo/common/widgets/custom_button.dart';
import 'package:plo/common/widgets/custom_text_input_box.dart';
import 'package:plo/views/settings_screen/provider/user_provider.dart';
import 'package:plo/views/settings_screen/settings_controller.dart';

class ProfileModifyScreen extends ConsumerStatefulWidget {
  const ProfileModifyScreen({super.key});

  @override
  ConsumerState<ProfileModifyScreen> createState() =>
      _ProfileModifyScreenState();
}

class _ProfileModifyScreenState extends ConsumerState<ProfileModifyScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final TextEditingController _nickname = TextEditingController();
  final TextEditingController _grade = TextEditingController();
  final TextEditingController _major = TextEditingController();

  @override
  void dispose() {
    _nickname.dispose();
    _grade.dispose();
    _major.dispose();
    super.dispose();
  }

  static const SizedBox defaultSpacing = SizedBox(height: 20);
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userInfoProvider);
    _grade.text = user.grade;
    _nickname.text = user.nickname;
    _major.text = user.major;

    return Scaffold(
      appBar: const BackButtonAppBar(title: "프로필 수정"),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                textInputBox(
                    text: "닉네임",
                    controller: _nickname,
                    validator: (value) => Validator.validateNickName(value)),
                defaultSpacing,
                textInputBox(
                    text: "학년",
                    controller: _grade,
                    validator: (value) => Validator.validateGrade(value)),
                defaultSpacing,
                textInputBox(
                    text: "전공",
                    controller: _major,
                    validator: (value) => Validator.validateMajor(value)),
                const SizedBox(height: 50),
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : CustomButton(
                        text: "변경사항 저장",
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              _isLoading = true;
                            });
                            final updatedUser =
                                await updateEditedUserdataToFirestore(
                                    _grade.text, _major.text, _nickname.text);
                            ref
                                .read(userInfoProvider.notifier)
                                .setUserdata(updatedUser);

                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => const HomeScreen()));
                            Navigator.pop(context);
                            setState(() {
                              _isLoading = false;
                            });
                          }
                        })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
