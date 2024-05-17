import 'package:flutter/material.dart';

Widget NumInputBox(BuildContext context, TextEditingController textController,
    {bool? wrongInput = false}) {
  return Material(
    elevation: 5,
    shadowColor: const Color.fromARGB(200, 0, 0, 0),
    child: Container(
      width: 75,
      decoration: BoxDecoration(
        border: Border.all(
            width: 1, color: wrongInput! ? Colors.red : Colors.black),
      ),
      child: TextField(
        controller: textController,
        maxLength: 1,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        style: const TextStyle(fontSize: 50),
        decoration: const InputDecoration(counterText: ''),
        showCursor: false,
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
          if (value.isEmpty) {
            FocusScope.of(context).previousFocus();
          }
        },
        onTap: () => FocusScope.of(context),
      ),
    ),
  );
}
