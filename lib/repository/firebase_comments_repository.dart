import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plo/constants/firebase_contants.dart';
import 'package:plo/model/comments_model.dart';
import 'package:plo/model/post_model.dart';

class CommentsRepository {
  final Ref ref;
  final _firestoreInstance = FirebaseFirestore.instance;
  CommentsRepository(this.ref);

  Future<bool> uploadCommentToFirebase(
      PostModel post, CommentModel comment, bool isForEdit) async {
    final commentModel = comment.toJson();
    try {
      if (isForEdit) {
        await _firestoreInstance
            .collection(FirebaseConstants.postcollectionName)
            .doc(post.pid)
            .collection(FirebaseConstants.commentscollectionName)
            .doc(comment.cid)
            .update(commentModel);
        log("Comment is updated in the firebase as the subCollection for the PostCollection");
        // await _firestoreInstance
        //     .collection(FirebaseConstants.commentscollectionName)
        //     .doc(comment.cid)
        //     .update(commentModel);
        // log("Comment is updated in the firebase for the comment collection");
      } else {
        final commentRef = await _firestoreInstance
            .collection(FirebaseConstants.postcollectionName)
            .doc(post.pid)
            .collection(FirebaseConstants.commentscollectionName)
            .doc(comment.cid)
            .set(commentModel);
        log("commentmodel is uploaded in the firebase as the subCollection for the PostCollection");
        // await _firestoreInstance
        //     .collection(FirebaseConstants.commentscollectionName)
        //     .doc(commentRef.id)
        //     .set(commentModel);
      }
      return true;
    } catch (error) {
      log("There was an error while uploading or updating in the firebase ${error.toString()}");
      return false;
    }
  }

  //이렇게 해보고 안 되면 String Pid 말고 아예 PostModel로 Controller도 바꿔주기.
  Future<List<CommentModel>?> fetchComments(String pid,
      {int amountFetch = 10, Timestamp? lastCommentUploadTime = null}) async {
    try {
      final QuerySnapshot querySnapshot;
      final commentSubCollectionRef = _firestoreInstance
          .collection(FirebaseConstants.postcollectionName)
          .doc(pid)
          .collection(FirebaseConstants.commentscollectionName);

      if (lastCommentUploadTime == null) {
        querySnapshot = await commentSubCollectionRef
            .orderBy(CommentModelFieldNameConstants.uploadTime,
                descending: true)
            .limit(amountFetch)
            .get();
        log("fetch comments for the initial 10 posts");
      } else {
        querySnapshot = await commentSubCollectionRef
            .orderBy(CommentModelFieldNameConstants.uploadTime,
                descending: true)
            .startAfter([lastCommentUploadTime])
            .limit(amountFetch)
            .get();
        log("fetched posts after 10 initial posts");
      }
      log("fetch comments from firebase");
      final List<CommentModel> fetchedComments = querySnapshot.docs
          .map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return CommentModel.fromJson(data);
          })
          .where((comment) => comment != null)
          .toList()
          .cast<CommentModel>();

      log("fetched Comments successfully");
      return fetchedComments;
    } catch (error) {
      log("there was an error fetching comments from the firebase ${error.toString()}");
      return null;
    }
  }

  Future<bool> deleteComments(PostModel post, CommentModel comment) async {
    try {
      await _firestoreInstance
          .collection(FirebaseConstants.postcollectionName)
          .doc(post.pid)
          .collection(FirebaseConstants.commentscollectionName)
          .doc(comment.cid)
          .delete();
      log("comment is deleted from the subcollection in the postcollection");

      // await _firestoreInstance
      //     .collection(FirebaseConstants.commentscollectionName)
      //     .doc(comment.cid)
      //     .delete();
      log("comment is deleted from the comment collection from the firebase");
      return true;
    } catch (error) {
      log("There was an error while deleting a comment from the firebase");
      return false;
    }
  }

  Future<CommentModel?> fetchCommentByCid(String pid, String cid) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await _firestoreInstance
              .collection(FirebaseConstants.postcollectionName)
              .doc(pid)
              .collection(FirebaseConstants.commentscollectionName)
              .doc(cid)
              .get();
      if (documentSnapshot.exists) {
        return CommentModel.fromJson(documentSnapshot.data()!);
      } else {
        return null;
      }
    } catch (error) {
      log("There was an error while fetching a single comment ${error.toString()}");
      return null;
    }
  }
}

final firebaseCommentRepository = Provider<CommentsRepository>((ref) {
  return CommentsRepository(ref);
});
