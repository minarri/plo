import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class StyleWidgets {
  static const Color shimmerBaseColor = Color.fromRGBO(224, 224, 224, 1);
  static const Color shimmerHighlightColor = Color.fromRGBO(245, 245, 245, 1);
  static const Color defaultButtonColor = Color.fromARGB(255, 60, 118, 231);
  static const SwiperPagination defaultPagination = SwiperPagination(
    alignment: Alignment.bottomCenter,
    builder: DotSwiperPaginationBuilder(color: Colors.white, activeColor: defaultButtonColor, activeSize: 10, size: 10),
  );

  static DefaultPagination({Color? baseColor, Color? activeColor}) {
    return SwiperPagination(
      alignment: Alignment.bottomCenter,
      builder: DotSwiperPaginationBuilder(
          color: baseColor ?? Colors.white, activeColor: activeColor ?? defaultButtonColor, activeSize: 10, size: 10),

    );
  }
}