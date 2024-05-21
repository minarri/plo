import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plo/common/validator/validator.dart';
import 'package:plo/model/types/category_type.dart';
import 'package:plo/views/post_write/post_write_controller.dart';
import 'package:plo/views/post_write/post_write_providers.dart';

class CreateEditPostFormWidget extends ConsumerWidget {
  final GlobalKey<FormState> formKey;
  const CreateEditPostFormWidget({super.key, required this.formKey});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const SizedBox defaultSpacing = SizedBox(height: 10);
    final postState = ref.watch(createEditPostStateProvider);
    return Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text("제목"),
            defaultSpacing,
            TextFormField(
              controller: ref
                  .watch(createEditPostStateController.notifier)
                  .titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.black),
                ),
                hintText: "제목",
              ),
              maxLength: 50,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              validator: (value) {
                return Validator.titleValidator(value);
              },
              onChanged: (value) {
                ref
                    .read(createEditPostStateProvider.notifier)
                    .updateTitle(value);
              },
               onTapOutside: (event) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
            ),
            defaultSpacing,
            const Text("카테고리"),
            DropdownButtonHideUnderline(
              child: DropdownButton2(
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black),
                buttonStyleData: ButtonStyleData(
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                dropdownStyleData: DropdownStyleData(
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  maxHeight: 150,
                  useSafeArea: true,
                ),
                menuItemStyleData: const MenuItemStyleData(),
                customButton: SizedBox(
                  width: double.infinity,
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        postState.category.toString(),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      const Icon(Icons.arrow_downward)
                    ],
                  ),
                ),
                items: CategoryType.values
                    .sublist(0, CategoryType.values.length)
                    .map(
                      (categories) => DropdownMenuItem(
                        alignment: Alignment.centerLeft,
                        value: categories.toString(),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        categories.toString(),
                                      ),
                                    ]),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    CategoryType newCategory =
                        CategoryType.stringToCategory(value);
                    ref
                        .read(createEditPostStateProvider.notifier)
                        .updateCategory(newCategory);
                  }
                },
              ),
            ),
            defaultSpacing,
            const Text("내용"),
            defaultSpacing,
            TextFormField(
              controller: ref
                  .read(createEditPostStateController.notifier)
                  .contentController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.black),
                ),
                hintText: "내용",
              ),
              maxLength: 500,
              minLines: 2,
              maxLines: 10,
              keyboardType: TextInputType.multiline,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              validator: (value) {
                return Validator.contentValidator(value);
              },
              onChanged: (value) {
                ref
                    .read(createEditPostStateProvider.notifier)
                    .updateContent(value);
              },
              onTapOutside: (event) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
            ),
          ],
        ));
  }
}
