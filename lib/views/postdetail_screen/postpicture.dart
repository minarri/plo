/*

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plo/common/widgets/pagination.dart';
import 'package:plo/model/post_model.dart';
import 'package:plo/providers/singlepost.dart';

class PostDetail extends ConsumerWidget {
  final PostModel postKey;
  const PostDetail({super.key, required this.postKey});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final post = ref.watch(singlePostProvider(postKey));
    return SizedBox(
      height: 400,
      child: Swiper(
        loop: false,
        pagination: StyleWidgets.defaultPagination(baseColor: Colors.grey),
        itemCount: post.contentImageUrlList.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ))
            }
          )
        }
      ),
    );
  }
}

*/