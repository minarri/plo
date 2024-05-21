import 'package:flutter/material.dart';

class NoMorePost extends StatelessWidget {
  const NoMorePost({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(height: 20),
        Text(
          "게시물이 더 이상 존재하지 않습니다.",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
