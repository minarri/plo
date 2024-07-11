import 'dart:io';

import 'package:plo/common/widgets/modal_bottomsheet/default_modal_bottom.dart';
import 'package:plo/views/post_write/post_write_providers.dart';
import 'package:plo/views/post_write/post_write_screen/widgets/post_create_images_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CreateEditPostImageOrderWidget extends ConsumerStatefulWidget {
  const CreateEditPostImageOrderWidget({super.key});
  @override
  ConsumerState<CreateEditPostImageOrderWidget> createState() =>
      _PhotoOrderState();
}

class _PhotoOrderState extends ConsumerState<CreateEditPostImageOrderWidget> {
  List<Object> _photos = [];
  Widget buildImageView(Object photo, int index, {bool isForProxy = false}) {
    return InkWell(
      key: UniqueKey(),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                CreateEditPostDetailWidget(index: index, photos: _photos),
          ),
        );
      },
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        margin: isForProxy ? null : const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                    height: double.infinity,
                    child: photo is File
                        ? Image.file(
                            photo,
                            fit: BoxFit.cover,
                          )
                        : const Text("There is an error loading the photo")),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 4,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "이미지 ${index + 1}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                    if (index == 0)
                      const FittedBox(
                        child: Text("썸네일 이미지"),
                      ),
                  ]),
            ),
            IconButton(
                onPressed: () {
                  _photos.removeAt(index);
                  setState(() {});
                },
                icon: const Icon(Icons.delete))
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    _photos = ref
        .read(createEditPostStateProvider)
        .photos
        .map((photo) => photo)
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultModalBottomSheet(
      child: Expanded(
        child: Column(
          children: [
            const Text("이미지 순서 선택"),
            Expanded(
              child: ReorderableListView(
                proxyDecorator: (child, index, animation) => Material(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: _photos
                        .map((photo) => buildImageView(
                            photo, _photos.indexOf(photo),
                            isForProxy: true))
                        .toList()[index],
                  ),
                ),
                onReorder: ((oldIndex, newIndex) {
                  if (oldIndex < newIndex) {
                    newIndex <= -1;
                  }
                  final Object post = _photos.removeAt(oldIndex);
                  _photos.insert(newIndex, post);
                  setState(() {});
                }),
                children: _photos
                    .map((photo) =>
                        buildImageView(photo, _photos.indexOf(photo)))
                    .toList(),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                ref
                    .read(createEditPostStateProvider.notifier)
                    .updatePhotos(_photos);
                Navigator.of(context).pop;
              },
              child: const Text("확인"),
            ),
          ],
        ),
      ),
    );
  }
}
