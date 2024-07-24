import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:plo/common/widgets/custom_app_bar.dart';
import 'package:plo/common/widgets/image_handler.dart';
import 'package:plo/common/widgets/style_widgets.dart';

class PostDetailPhotoview extends StatelessWidget {
  List<String> photoUrl;
  int initialIndex;
  PostDetailPhotoview(
      {super.key, required this.photoUrl, required this.initialIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BackButtonAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(flex: 1),
            Expanded(
              flex: 8,
              child: Swiper(
                  loop: false,
                  pagination:
                      StyleWidgets.DefaultPagination(baseColor: Colors.grey),
                  outer: true,
                  index: initialIndex,
                  itemCount: photoUrl.length,
                  itemBuilder: (context, index) {
                    return InteractiveViewer(
                      maxScale: 5,
                      child: ImageHandlerWidget(
                        fit: BoxFit.contain,
                        imageUrl: photoUrl[index],
                        isForView: true,
                      ),
                    );
                  }),
            ),
            const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}
