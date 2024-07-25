import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plo/common/providers/singlepost.dart';
import 'package:plo/common/widgets/image_handler.dart';
import 'package:plo/common/widgets/style_widgets.dart';
import 'package:plo/model/post_model.dart';
import 'package:plo/views/postdetail_screen/postpicture_view.dart';

class PostDetailPhoto extends ConsumerWidget {
  final PostModel postKey;
  const PostDetailPhoto({super.key, required this.postKey});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final post = ref.watch(singlePostProvider(postKey));
    if (post.contentImageUrlList.isEmpty) {
      return SizedBox.shrink();
    }
    return SizedBox(
      height: 300,
      child: Swiper(
        loop: false,
        pagination: StyleWidgets.DefaultPagination(baseColor: Colors.grey),
        itemCount: post.contentImageUrlList.length,
        itemBuilder: (context, index) {
          return InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PostDetailPhotoview(
                        photoUrl: post.contentImageUrlList,
                        initialIndex: index)));
              },
              child: ImageHandlerWidget(
                imageUrl: post.contentImageUrlList[index],
              ));
        },
      ),
    );
  }
}
