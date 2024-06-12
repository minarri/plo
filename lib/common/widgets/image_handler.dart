import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:plo/common/utils/log_util.dart';
import 'package:plo/common/widgets/no_more_post.dart';
import 'package:plo/common/widgets/shimmer_style.dart';
import 'package:plo/common/widgets/style_widgets.dart';
class ImageHandlerWidget extends ConsumerWidget {
  final bool isForView;
  final String imageUrl;
  final BoxFit fit;
  const ImageHandlerWidget({super.key, this.fit = BoxFit.cover, required this.imageUrl, this.isForView = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CachedNetworkImage(
      fit: fit,
      imageUrl: imageUrl,
      placeholder: (context, url) {
        return ShimmerIndividualWidget(
            child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                color: StyleWidgets.shimmerBaseColor,
              ),
            ),
          ],
        ));
      },
      errorWidget: (context, url, error) {
        logToConsole("ImageHandlerWidget error : $error");
        return const NoMorePost();
      },
    );
  }
}