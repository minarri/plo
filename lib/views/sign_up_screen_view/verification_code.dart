import 'dart:async';

import 'package:flutter/material.dart';
import 'package:plo/common/widgets/custom_app_bar.dart';
import 'package:plo/common/widgets/custom_button.dart';
import 'package:plo/common/widgets/my_widgets.dart';
import 'package:plo/model/erro_handling/error_handler.dart';
import 'package:plo/views/Terms_of_service_screen/terms_of_service_screen.dart';
import 'package:plo/views/sign_up_screen_view/sign_up_screen_controller.dart';
import 'package:plo/views/sign_up_screen_view/widgets/num_input_box.dart';

class VerifyCodeScreen extends StatefulWidget {
  VerifyCodeScreen(
      {super.key, required this.emailcontroller, required this.otpHash});

  final TextEditingController emailcontroller;
  String otpHash;

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  bool invalidVertCode = false;
  int resendTime = 180;
  late Timer countdownTimer;
  TextEditingController txt1 = TextEditingController();
  TextEditingController txt2 = TextEditingController();
  TextEditingController txt3 = TextEditingController();
  TextEditingController txt4 = TextEditingController();

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    txt1.dispose();
    txt2.dispose();
    txt3.dispose();
    txt4.dispose();
    super.dispose();
  }

  // Function to start the countdown timer
  void _startTimer() {
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        resendTime -= 1;
      });
      if (resendTime < 1) {
        _stopTimer();
      }
    });
  }

  // Function to stop the countdown timer
  void _stopTimer() {
    if (countdownTimer.isActive) {
      countdownTimer.cancel();
    }
  }

  // Function to convert seconds to '0:00' format
  _convSecToMin(int seconds) {
    String minutesStr = (seconds ~/ 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    return '$minutesStr:$secondsStr';
  }

  // Function to verify the entered verification code
  void _verifyVerifyCode() async {
    final vertCode = txt1.text + txt2.text + txt3.text + txt4.text;
    var res = await verifyVerifyCode(
        widget.emailcontroller, widget.otpHash, vertCode);
    res.fold(
        (errorMessage) => ErrorHandler().showSnackBar(context, errorMessage),
        (response) {
      if (resendTime != 0 && response.data == "Success") {
        _stopTimer();
        setState(() {
          invalidVertCode = false;
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const TermsOfServiceScreen(),
          ),
        );
      } else {
        setState(() {
          invalidVertCode = true;
        });
      }
    });
  }

  void _resendVerifyCode() async {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => alertInputBox(
              context: context,
              title: "알림",
              content: "이메일이 다시 발송되었습니다.",
            ));
    var res = await sendVerifyCodeToEmail(widget.emailcontroller);
    res.fold(
        (errorMessage) => ErrorHandler().showSnackBar(context, errorMessage),
        (response) {
      widget.otpHash = response.data!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: const BackButtonAppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                //나중에 plo로고로 대체해야 합니다.
                const Icon(
                  Icons.person,
                  size: 80,
                ),
                const Text(
                  '학교인증',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 30),
                Row(
                  children: [
                    const Text(
                      '인증번호',
                      style: TextStyle(fontSize: 20),
                    ),
                    if (resendTime >= 0)
                      Text(
                        _convSecToMin(resendTime),
                        style: const TextStyle(
                          color: Color(0xFF3A6DF2),
                          fontSize: 16,
                        ),
                      )
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    NumInputBox(context, txt1, wrongInput: invalidVertCode),
                    NumInputBox(context, txt2, wrongInput: invalidVertCode),
                    NumInputBox(context, txt3, wrongInput: invalidVertCode),
                    NumInputBox(context, txt4, wrongInput: invalidVertCode),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (resendTime != 0)
                      Text(
                        invalidVertCode ? "인증번호가 일치하지 않습니다" : '',
                        style: const TextStyle(fontSize: 16, color: Colors.red),
                      ),
                    if (resendTime == 0)
                      const Text(
                        "시간이 초과되었습니다",
                        style: TextStyle(fontSize: 16, color: Colors.red),
                      ),
                    InkWell(
                      onTap: () {
                        //resend opt code
                        invalidVertCode = false;
                        if (countdownTimer.isActive) {
                          _stopTimer();
                        }
                        resendTime = 180; //set to 3 mins
                        _startTimer();
                        _resendVerifyCode();
                      },
                      child: const Text(
                        '다시 요청',
                        style: TextStyle(
                            color: Color(0xFF3A6DF2),
                            fontSize: 17,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 90),
                CustomButton(text: '인증완료', onPressed: _verifyVerifyCode)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
