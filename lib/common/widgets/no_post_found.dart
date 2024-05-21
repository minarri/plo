import 'package:flutter/material.dart';

class NoPostFound extends StatelessWidget {
  final String message;
  const NoPostFound({super.key, this.message = "게시물이 존재하지 않습니다"});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Icon(Icons.error, size: 100),
          FittedBox(
            child: Text(
              message,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
