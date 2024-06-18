import 'dart:io';
import 'package:plo/repository/auth_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectedFileNotifier extends StateNotifier<File?> {
  SelectedFileNotifier() : super(null);
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final auth = AuthMethods();
  //
  void setFile(File? file) {
    state = file;
  }

  Future<bool> checkNickNameDupsThenSignUp(String email, String password,
      String nickname, String grade, String major, File? profilePic) async {
    //콜렉션 users안의 document들 중에서 필드 이름이 nickname이고 그 value가 parameter와 같은 document들만 있는 query
    QuerySnapshot query = await _firestore
        .collection('users')
        .where('nickname', isEqualTo: nickname)
        .get();

    if (query.docs.isNotEmpty) {
      return false;
    }
    await auth.signUpUser(
      email: email,
      password: password,
      nickname: nickname,
      grade: grade,
      major: major,
      file: profilePic,
    );
    return true;
  }
}

final selectedFile = StateNotifierProvider<SelectedFileNotifier, File?>(
    (ref) => SelectedFileNotifier());
