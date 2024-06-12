import 'dart:async';

import 'package:flutter/material.dart';
import 'package:plo/common/widgets/custom_app_bar.dart';
import 'package:plo/common/widgets/my_widgets.dart';
import 'package:plo/services/api_service.dart';
import 'package:plo/views/profile_create_screen/profile_create.dart';

class VertCodeScreen extends StatefulWidget {
  VertCodeScreen(
      {super.key, required this.emailcontroller, required this.otpHash});

  final TextEditingController emailcontroller;
  String otpHash;

  @override
  State<VertCodeScreen> createState() => _VertCodeScreenState();
}

class _VertCodeScreenState extends State<VertCodeScreen> {
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
    startTimer();
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
  void startTimer() {
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        resendTime -= 1;
      });
      if (resendTime < 1) {
        stopTimer();
      }
    });
  }

  // Function to stop the countdown timer
  void stopTimer() {
    if (countdownTimer.isActive) {
      countdownTimer.cancel();
    }
  }

  // Function to convert seconds to '0:00' format
  convSecToMin(int seconds) {
    String minutesStr = (seconds ~/ 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    return '$minutesStr:$secondsStr';
  }

  // Function to verify the entered verification code
  void verifyVertCode() {
    final vertCode = txt1.text + txt2.text + txt3.text + txt4.text;
    EmailAPIService.verifyOTP(
            widget.emailcontroller.text, widget.otpHash, vertCode)
        .then((response) {
      if (resendTime != 0 &&
          response.data != null &&
          response.data == "Success") {
        stopTimer();
        setState(() {
          invalidVertCode = false;
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ProfileCreate(),
          ),
        );
      } else {
        setState(() {
          invalidVertCode = true;
        });
      }
    });
  }

  resendVertCode() {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => alertInputBox(
              context: context,
              title: "알림",
              content: "이메일이 다시 발송되었습니다.",
            ));
    EmailAPIService.otpLogin(widget.emailcontroller.text).then((res) {
      widget.otpHash = res.data!;
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
                  style: TextStyle(fontSize: 24),
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
                        convSecToMin(resendTime),
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
                          stopTimer();
                        }
                        resendTime = 180; //set to 3 mins
                        startTimer();
                        resendVertCode();
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
                ButtonBox(
                    text: '인증 완료',
                    boxWidth: 160,
                    boxHeight: 61,
                    buttonFunc: verifyVertCode)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
