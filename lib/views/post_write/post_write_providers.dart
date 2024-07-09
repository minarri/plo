import 'package:plo/extensions/ref_dipsose.dart';
import 'package:plo/model/state_model/create_edit_post_model.dart';
import 'package:plo/model/types/category_type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final createEditPostStateProvider = StateNotifierProvider.autoDispose<
    CreateEditPostStateNotifier, CreateEditPostModel>((ref) {
  ref.logDisposeToConsole("CreateorEEditPostStateProvider");
  return CreateEditPostStateNotifier();
});

final createEditPostStateProviderFamily = StateNotifierProvider.autoDispose
    .family<CreateEditPostStateNotifier, CreateEditPostModel,
        CreateEditPostModel?>((ref, editPostInformation) {
  return CreateEditPostStateNotifier(editInformation: editPostInformation);
});

class CreateEditPostStateNotifier extends StateNotifier<CreateEditPostModel> {
  CreateEditPostModel? editInformation;
  CreateEditPostStateNotifier({this.editInformation})
      : super(CreateEditPostModel()) {
    if (editInformation != null) {
      state = editInformation!;
    }
  }

  initforEdit(CreateEditPostModel editPostInformation) {
    state = editPostInformation;
  }

  void setState(CreateEditPostModel newState) {
    state = newState;
  }

  void updatePhotos(List<Object> photos) {
    state = state.update(photos: photos);
  }

  void updateTitle(String postTitle) {
    state = state.update(postTitle: postTitle);
  }

  void updateContent(String postContent) {
    state = state.update(postContent: postContent);
  }

  void updateCategory(CategoryType category) {
    state = state.update(category: category);
  }
}
