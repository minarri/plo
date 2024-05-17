import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFCCE7FF),
          foregroundColor: Colors.black,
          //padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          side: const BorderSide(color: Colors.transparent),
          shadowColor: const Color.fromARGB(200, 0, 0, 0),
          elevation: 5,
        ),
        child: Text(text),
      ),
    );
  }
}
