import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plo/common/widgets/custom_app_bar.dart';
import 'package:plo/model/comments_model.dart';
import 'package:plo/model/post_model.dart';
import 'package:plo/views/postdetail_screen/report_screen/report_form_widget.dart';
import 'package:plo/views/postdetail_screen/report_screen/report_screen_comment/report_form_comment.dart';
import 'package:plo/views/postdetail_screen/report_screen/report_screen_controller.dart';

class ReportCommentScreen extends ConsumerStatefulWidget {
  final CommentModel commentKey;
  const ReportCommentScreen({super.key, required this.commentKey});

  @override
  ConsumerState<ReportCommentScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends ConsumerState<ReportCommentScreen> {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(reportPostControllerProvider);
    return Scaffold(
      appBar: const BackButtonAppBar(title: "신고하기"),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(8),
            child: SingleChildScrollView(
                controller: _scrollController,
                child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(children: [
                      ReportCommentFormWidget(
                          commentKey: widget.commentKey,
                          scrollController: _scrollController),
                      if (state.isLoading) const CircularProgressIndicator(),
                      if (state.hasError) Text("Error ${state.error}"),
                    ])))),
      ),
    );
  }
}
