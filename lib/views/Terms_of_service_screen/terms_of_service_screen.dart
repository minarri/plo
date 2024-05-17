import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plo/common/widgets/custom_app_bar.dart';
import 'package:plo/common/widgets/custom_button.dart';
import 'package:plo/common/widgets/custom_screen.dart';
import 'package:plo/views/Terms_of_service_screen/provider/terms_provider.dart';
import 'package:plo/views/Terms_of_service_screen/term1.dart';
import 'package:plo/views/Terms_of_service_screen/term2.dart';
import 'package:plo/views/Terms_of_service_screen/term3.dart';
import 'package:plo/views/Terms_of_service_screen/widgets/checkbox_widget.dart';
import 'package:plo/views/profile_create_screen/profile_create.dart';

class TermsOfServiceScreen extends ConsumerStatefulWidget {
  const TermsOfServiceScreen({super.key});

  @override
  ConsumerState<TermsOfServiceScreen> createState() =>
      _TermsOfServiceScreenState();
}

class _TermsOfServiceScreenState extends ConsumerState<TermsOfServiceScreen> {
  bool? _allIsChecked = false;
  bool? _firstIsChecked = false;
  bool? _secondIsChecked = false;
  bool? _thridIsChecked = false;

  void validateCheckBox() {
    if (_allIsChecked! || (_firstIsChecked! && _secondIsChecked!)) {
      //다음페이지
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ProfileCreate(),
          ));
    } else {
      ref
          .watch(termsInfoProvider.notifier)
          .setCheckBoxes(_firstIsChecked, _secondIsChecked, _thridIsChecked);
    }
  }

  void checkAll() {
    _firstIsChecked = true;
    _secondIsChecked = true;
    _thridIsChecked = true;
  }

  void uncheckAll() {
    _firstIsChecked = false;
    _secondIsChecked = false;
    _thridIsChecked = false;
  }

  @override
  Widget build(BuildContext context) {
    return CustomInitialScreen(
      appBar: const BackButtonAppBar(),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        //나중에 plo로고로 대체해야 합니다.
        const Icon(
          Icons.person,
          size: 80,
        ),
        const Text(
          '약관동의',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 50),
        Row(
          children: [
            Transform.scale(
              scale: 2,
              child: Checkbox(
                value: _allIsChecked,
                checkColor: Colors.black,
                activeColor: const Color.fromARGB(255, 204, 231, 255),
                onChanged: (value) {
                  setState(() {
                    _allIsChecked = value;
                    if (_allIsChecked!) {
                      checkAll();
                    } else {
                      uncheckAll();
                    }
                  });
                },
              ),
            ),
            const SizedBox(width: 5),
            const Text("약관 전체동의",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))
          ],
        ),
        const SizedBox(height: 10),
        const Divider(
          color: CupertinoColors.systemGrey5,
          thickness: 5,
        ),

        CheckBoxWidget(
          id: 1,
          title: "어쩌고 저쩌고 동의",
          subtitle: "(필수)",
          checkBox: Checkbox(
            value: _firstIsChecked,
            checkColor: Colors.black,
            activeColor: const Color.fromARGB(255, 204, 231, 255),
            onChanged: (value) {
              setState(() {
                _firstIsChecked = value;
                if (_allIsChecked! && _firstIsChecked == false) {
                  _allIsChecked = false;
                }
              });
            },
          ),
          callback: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Term1(),
                ));
          },
        ),
        CheckBoxWidget(
          id: 2,
          title: "어쩌고 저쩌고 동의2",
          subtitle: "(필수)",
          checkBox: Checkbox(
            value: _secondIsChecked,
            checkColor: Colors.black,
            activeColor: const Color.fromARGB(255, 204, 231, 255),
            onChanged: (value) {
              setState(() {
                _secondIsChecked = value;
                if (_allIsChecked! && _secondIsChecked == false) {
                  _allIsChecked = false;
                }
              });
            },
          ),
          callback: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Term2(),
                ));
          },
        ),
        CheckBoxWidget(
          title: "어쩌고 저쩌고 동의3",
          subtitle: "(선택)",
          checkBox: Checkbox(
            value: _thridIsChecked,
            checkColor: Colors.black,
            activeColor: const Color.fromARGB(255, 204, 231, 255),
            onChanged: (value) {
              setState(() {
                _thridIsChecked = value;
                if (_allIsChecked! && _thridIsChecked == false) {
                  _allIsChecked = false;
                }
              });
            },
          ),
          callback: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Term3(),
                ));
          },
        ),

        const SizedBox(height: 50),
        CustomButton(text: "다음", onPressed: validateCheckBox),
      ]),
    );
  }
}
