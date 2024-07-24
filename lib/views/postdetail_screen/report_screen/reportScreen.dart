import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plo/common/widgets/custom_app_bar.dart';
import 'package:plo/model/post_model.dart';
import 'package:plo/views/postdetail_screen/report_screen/report_form_widget.dart';
import 'package:plo/views/postdetail_screen/report_screen/report_screen_controller.dart';

class ReportScreen extends ConsumerStatefulWidget {
  final PostModel postKey;
  const ReportScreen({super.key, required this.postKey});

  @override
  ConsumerState<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends ConsumerState<ReportScreen> {
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
                      ReportFormWidget(
                          postKey: widget.postKey,
                          scrollController: _scrollController),
                      if (state.isLoading) const CircularProgressIndicator(),
                      if (state.hasError) Text("Error ${state.error}"),
                    ])))),
      ),
    );
  }
}