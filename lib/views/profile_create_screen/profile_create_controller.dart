import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectedFileNotifier extends StateNotifier<File?> {
  SelectedFileNotifier() : super(null);
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //
  void setFile(File? file) {
    state = file;
  }

  Future checkDuplicate(String? nickname) async {
    //콜렉션 users안의 document들 중에서 필드 이름이 nickname이고 그 value가 parameter와 같은 document들만 있는 query
    QuerySnapshot query = await _firestore
        .collection('users')
        .where('nickname', isEqualTo: nickname!)
        .get();

    if (query.docs.isNotEmpty) {
      throw Exception('Duplicate Nickname exists');
    }
    return;
  }
}

final selectedFile = StateNotifierProvider<SelectedFileNotifier, File?>(
    (ref) => SelectedFileNotifier());
