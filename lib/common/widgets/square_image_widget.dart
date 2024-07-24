import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SquareImageWidget extends StatelessWidget {
  final String postImageUrl;
  const SquareImageWidget({super.key, required this.postImageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
          imageUrl: postImageUrl,
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
          placeholder: (context, url) => Container(
            color: Colors.transparent,
          ),
          errorWidget: (context, url, error) => Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: const Center(
              child: Column(
                children: [
                  Icon(Icons.error_outline, size: 50),
                  SizedBox(height: 10),
                  FittedBox(
                    child: Text("에러가 났습니다"),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
