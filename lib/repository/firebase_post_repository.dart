import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plo/common/utils/log_util.dart';
import 'package:plo/constants/firebase_contants.dart';
import 'package:plo/model/post_model.dart';
import 'package:plo/model/types/category_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebasePostRepository {
  final Ref ref;
  FirebasePostRepository(this.ref);
  final firestoreinstance = FirebaseFirestore.instance;

  void _logHelper(String typeofAction, String functionName) {
    logToConsole(
        "Firestore was used $typeofAction in $functionName in FirebasePostRepository");
  }

  Future<bool> uploadPostFirebase(PostModel postModel, bool isforEdit) async {
    try {
      if (isforEdit) {
        await firestoreinstance
            .collection(FirebaseConstants.postcollectionName)
            .doc(postModel.pid)
            .update(postModel.toJson());
      } else {
        await firestoreinstance
            .collection(FirebaseConstants.postcollectionName)
            .doc(postModel.pid)
            .set(postModel.toJson());
      }
      return true;
    } catch (error) {
      logToConsole("UploadPostModelrror : error ${error.toString()}");
      return false;
    }
  }

  //fetching category by the upload time
  Future<List<PostModel>?> fetchPost(
      {Timestamp? lastPostUploadTime, int amountFetch = 10}) async {
    try {
      final QuerySnapshot querySnapshot;

      if (lastPostUploadTime == null) {
        querySnapshot = await FirebaseFirestore.instance
            .collection(FirebaseConstants.postcollectionName)
            .where(PostModelFieldNameConstants.category,
                whereIn: [CategoryType.information.toString()])
            .orderBy(PostModelFieldNameConstants.uploadTime, descending: true)
            .limit(amountFetch)
            .get();
      } else {
        querySnapshot = await FirebaseFirestore.instance
            .collection(FirebaseConstants.postcollectionName)
            .where(PostModelFieldNameConstants.category,
                whereIn: [CategoryType.general.toString()])
            .orderBy(PostModelFieldNameConstants.uploadTime, descending: true)
            .limit(amountFetch)
            .get();
      }

      final List<PostModel> fetchedPosts = [];
      for (int i = 0; i < querySnapshot.size; i++) {
        final post = PostModel()
            .fromJson(querySnapshot.docs[i].data() as Map<String, dynamic>);
        if (post != null) fetchedPosts.add(post);
      }
      return fetchedPosts;
    } catch (error) {
      return null;
    }
  }
  Future<PostModel?> fetchPostByPostUid(String pid) async {
  try {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await FirebaseFirestore.instance.collection(FirebaseConstants.postcollectionName).doc(pid).get();
    if(documentSnapshot.exists) {
      return PostModel().fromJson(documentSnapshot.data()!);
    } else {
      return null;
    }
  } catch (error) {
    logToConsole("Fetch by singlePost error: ${error.toString()}");
    return null;
  }
}
}

final firebasePostRepository = Provider<FirebasePostRepository>((ref) {
  return FirebasePostRepository(ref);
});
