import 'package:flutter/material.dart';
import 'package:plo/model/post_model.dart';
import 'package:plo/views/postdetail_screen/report_screen/reportScreen.dart';

class PostReportWidget extends StatelessWidget {
  final PostModel postKey;
  const PostReportWidget({super.key, required this.postKey});

  @override

  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) =>  ReportScreen(postKey: postKey))
        );
      }
    );
  }
}