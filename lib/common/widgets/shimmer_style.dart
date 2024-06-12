import 'package:flutter/material.dart';
import 'package:plo/common/widgets/style_widgets.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerIndividualWidget extends StatelessWidget {
  final Widget child;
  const ShimmerIndividualWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        
        baseColor: StyleWidgets.shimmerBaseColor,
        highlightColor: StyleWidgets.shimmerHighlightColor, child: child,);
  }
}
