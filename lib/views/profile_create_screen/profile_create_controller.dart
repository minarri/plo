import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectedFileNotifier extends StateNotifier<File?> {
  SelectedFileNotifier() : super(null);
  final db = FirebaseFirestore.instance;
  

  //
  void setFile(File? file) {
    state = file;
  }

  Future<bool> checkDuplicate(String? nickname) async {
    //콜렉션 users안의 document들 중에서 필드 이름이 nickname이고 그 value가 parameter와 같은 document들만 있는 query
    QuerySnapshot dupQuery = await db
        .collection('users')
        .where('nickname', isEqualTo: nickname!)
        .get();

    if (dupQuery.docs.isEmpty) {
      print('pass');
      return true; //pass - no duplicate
    }
    print('fail');
    return false; //fail - duplicate exists
  }
}

final selectedFile = StateNotifierProvider<SelectedFileNotifier, File?>(
    (ref) => SelectedFileNotifier());
