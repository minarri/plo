import 'dart:io';

import 'package:card_swiper/card_swiper.dart';
import 'package:plo/common/utils/log_util.dart';
import 'package:plo/common/widgets/style_widgets.dart';
import 'package:plo/views/post_write/post_write_controller.dart';
import 'package:plo/views/post_write/post_write_providers.dart';
import 'package:plo/views/post_write/post_write_screen/widgets/post_image_order.dart';
import 'package:plo/views/post_write/post_write_screen/widgets/post_image_bottomsheet.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_riverpod/flutter_riverpod.dart';

final imageLoadingProvider = StateProvider.autoDispose<bool>((ref) => false);

class CreateEditPostImageViewWidget extends ConsumerStatefulWidget {
  const CreateEditPostImageViewWidget({super.key});
  @override
  ConsumerState<CreateEditPostImageViewWidget> createState() =>
      _ImageViewWidgetState();
}

class _ImageViewWidgetState
    extends ConsumerState<CreateEditPostImageViewWidget> {
  @override
  Widget build(BuildContext context) {
    final List<Object> photos = ref.watch(createEditPostStateProvider).photos;
    final bool imageLoading = ref.watch(imageLoadingProvider);
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Stack(
        children: [
          Container(
            height: 400,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(15),
            ),
            child: imageLoading
                ? const Center(child: CircularProgressIndicator())
                : photos.isEmpty
                    ? const Center(
                        child: Icon(
                          Icons.camera_alt,
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                  child:
                                      const CreateEditPostImageOrderWidget());
                            },
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Swiper(
                              controller: ref
                                  .watch(createEditPostStateController.notifier)
                                  .swiperController,
                              loop: false,
                              pagination: StyleWidgets.DefaultPagination(),
                              itemCount: photos.length,
                              itemBuilder: (context, index) =>
                                  CreateEditPostNetworkImage(
                                      image: photos[index])),
                        ),
                      ),
          ),
          if (photos.isNotEmpty)
            Positioned(
              bottom: 5,
              right: 5,
              child: Tooltip(
                padding: const EdgeInsets.all(10),
                triggerMode: TooltipTriggerMode.tap,
                message: "이미지를 클릭해서 이미지를 지우거나 순서를 정하세요",
                child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      border: Border.all(color: Colors.black),
                    ),
                    child: const Icon(Icons.question_mark_outlined, size: 20)),
              ),
            ),
        ],
      ),
      // if (photos.isNotEmpty)
      //   Positioned(
      //     bottom: 5,
      //     right: 5,
      //     child: Tooltip(
      //       padding: EdgeInsets.all(10),
      //       triggerMode: TooltipTriggerMode.tap,
      //       message: "이미지를 클릭해서 이미지를 지우거나 순서를 정하세요",
      //       child: Container(
      //           decoration: BoxDecoration(
      //             shape: BoxShape.rectangle,
      //             color: Colors.white,
      //             border: Border.all(color: Colors.black),
      //           ),
      //           child: const Icon(Icons.question_mark, size: 20)),
      //     ),
      //   ),
      const SizedBox(height: 10),
      ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Container(child: const CreateEditPostImage());
              },
            );
          },
          child: const Text("사진 추가"))
    ]);
  }
}

class CreateEditPostNetworkImage extends StatefulWidget {
  final Object image;
  const CreateEditPostNetworkImage({super.key, required this.image});

  @override
  State<CreateEditPostNetworkImage> createState() =>
      _CreateEditPostNetworkImageState();
}

class _CreateEditPostNetworkImageState
    extends State<CreateEditPostNetworkImage> {
  bool isImageError = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: isImageError
            ? null
            : DecorationImage(
                onError: (exception, stackTrace) {
                  setState(() {
                    logToConsole("Image Error");
                    isImageError = true;
                  });
                },
                fit: BoxFit.cover,
                image: (widget.image is File)
                    ? FileImage(widget.image as File)
                    : NetworkImage(widget.image as String) as ImageProvider),
      ),
      child: isImageError ? const Text("There is an error") : null,
    );
  }
}
