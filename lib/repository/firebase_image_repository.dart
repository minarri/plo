import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plo/common/utils/log_util.dart';
import 'package:plo/constants/firebase_contants.dart';
import 'package:plo/model/post_model.dart';

class FirebaseImageRepository {
  Future<bool> deletePostPhotos(PostModel post) async {
    try {
      List<String> imageList = [];

      for (String url in post.contentImageUrlList) {
        Uri imageUrl = Uri.parse(url);
        String lastSegment = imageUrl.pathSegments.last;
        imageList.add(lastSegment);
      }
      for (String imageName in imageList) {
        String path = '${post.uploadUserUid}/${post.pid}/$imageName';
        FirebaseStorage.instance.ref().child(path).delete();
      }
      return true;

    } catch (e) {
      logToConsole("deletePostPhotosError : ${e.toString()}");
      return false;
    }
    
  }
}

final FirebaseImageRepositoryProvider = Provider<FirebaseImageRepository>((ref)  {
  return FirebaseImageRepository();
});