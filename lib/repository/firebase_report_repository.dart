import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plo/common/utils/log_util.dart';
import 'package:plo/constants/firebase_contants.dart';
import 'package:plo/model/post_model.dart';
import 'package:plo/model/types/post_report_model.dart';
import 'package:plo/model/types/return_type.dart';
import 'package:plo/repository/firebase_user_repository.dart';

class FirebaseReportRepository {
  final Ref ref;
  FirebaseReportRepository ({required this.ref});

  final _firebase = FirebaseFirestore.instance;

  void _logHelper(String typeofAction, String functionName) {
    logToConsole("Firestore was used in $typeofAction in $functionName in firebasePostRepository");
  }
  Future<ReturnType> alreadyReported(String pid) async {
    try {
      final user = ref.watch(firebaseUserRepositoryProvider).currentUser;
      if(user ==null) return ErrorReturnType(message: "User wasn't found");

      final doc = await  _firebase.collection(FirebaseConstants.reportRecordscollectionName).doc(pid).collection(FirebaseConstants.reportRecordscollectionName).doc(user.uid).get();
      if(!doc.exists) return SuccessReturnType(message: "User did not report this Post", isSuccess: false);
      return SuccessReturnType(isSuccess: true);
    } catch (error) {
      return ErrorReturnType(message: "게시물이 이미 신고 되었습니다: $error", data: error);
    }
  }
  Future<ReturnType> uploadPostReportModelToFirebase(PostReportModel postReportModel, PostModel post) async {
    try {
      final isReported = await alreadyReported(post.pid);

      await _firebase.collection(FirebaseConstants.reportRecordscollectionName).doc(post.pid).set({
        PostModelFieldNameConstants.pid: post.pid,
      });

      if (isReported is SuccessReturnType && isReported.isSuccess == true) {
        await _firebase.collection(FirebaseConstants.reportRecordscollectionName).doc(post.pid).collection(FirebaseConstants.reportRecordscollectionName).doc(postReportModel.reportingUserUid).update(postReportModel.toJson());
        _logHelper("Update", "uploadPostReportModelToFirebase");
      } else {
        await _firebase.collection(FirebaseConstants.reportRecordscollectionName).doc(post.pid).collection(FirebaseConstants.reportRecordscollectionName).doc(postReportModel.reportingUserUid).set(postReportModel.toJson());
        _logHelper("Set", "uploadPostReportModelToFirebase");
      }
      return SuccessReturnType(isSuccess: true);
    } catch (error) {
      return ErrorReturnType(message: error.toString(), data: error);
    }
  }
}


final firebaseReportRepositoryProvider = Provider<FirebaseReportRepository>((ref) {
  ref.onDispose(() {
    logToConsole('FirebasePostRepositoryProvider Disposed');
  });
  return FirebaseReportRepository(ref: ref);
});