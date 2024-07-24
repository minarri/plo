import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plo/common/utils/riverpod_error.dart';
import 'package:plo/common/widgets/test_appbar.dart';
import 'package:plo/model/state_model/create_edit_post_model.dart';
import 'package:plo/views/home_screen/main_post_list_controller.dart';
import 'package:plo/views/post_write/post_write_controller.dart';
import 'package:plo/views/post_write/post_write_providers.dart';
import 'package:plo/views/post_write/post_write_screen/widgets/post_create_form.dart';
import 'package:plo/views/post_write/post_write_screen/widgets/post_image_view.dart';

class CreateEditPostScreen extends ConsumerStatefulWidget {
  final CreateEditPostModel? editPostInformation;
  const CreateEditPostScreen({super.key, this.editPostInformation});

  @override
  ConsumerState<CreateEditPostScreen> createState() =>
      _CreateEditPostScreenState();
}

class _CreateEditPostScreenState extends ConsumerState<CreateEditPostScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.editPostInformation != null) {
        ref
            .watch(createEditPostStateController.notifier)
            .initAllFieldforEdit(widget.editPostInformation!);
        ref
            .watch(createEditPostStateProvider.notifier)
            .initforEdit(widget.editPostInformation!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    RiverpodErrorHelperFunction.showSnackBarOnError(
        ref, createEditPostStateController, context);

    final state = ref.watch(createEditPostStateController);
    var postState = ref.watch(createEditPostStateProvider);

    return Scaffold(
        appBar: TestAppbarWidget(
            title: postState.isForEdit ? "Edit Post" : "Write Post"),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(children: [
                const CreateEditPostImageViewWidget(),
                const SizedBox(height: 10),
                CreateEditPostFormWidget(formKey: _formKey),
                TextButton(
                  onPressed: () async {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) =>
                            const Center(child: CircularProgressIndicator()));
                    final result = await ref
                        .read(createEditPostStateController.notifier)
                        .uploadPost(formKey: _formKey);
                    if (result == true) {
                      ref.refresh(mainpostListController);
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    } else {
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text("작성"),
                )
              ]),
            ),
          ),
        ));
  }
}
