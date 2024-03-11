import 'dart:io';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class CreateEditPostDetailWidget extends StatelessWidget {
  int index;
  List<Object> photos = [];
  CreateEditPostDetailWidget(
      {super.key, required this.index, required this.photos});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
            child: Column(
          children: [
            Expanded(
              child: Swiper(
                key: UniqueKey(),
                loop: false,
                index: index,
                itemCount: photos.length,
                itemBuilder: (context, index) => InteractiveViewer(
                  child: Container(
                    child: photos[index] is File
                        ? Image.file(photos[index] as File)
                        : Text("No More photos"),
                  ),
                ),
              ),
            ),
          ],
        )));
  }
}
