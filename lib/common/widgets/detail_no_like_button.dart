import 'package:flutter/material.dart';

class DetailNoLikeButton extends StatelessWidget {
  const DetailNoLikeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Icon(Icons.heart_broken),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("로그인 해야 이용 가능한 기능입니다")));
        });
  }
}
