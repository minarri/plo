import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plo/constants/firebase_contants.dart';
import 'package:plo/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FirebaseUserRepository {
  final _auth = FirebaseAuth.instance;
  final usercollectionName = FirebaseConstants.usercollectionName;
  void _logHelper(String typeofAction, String funcitonName) {
    log("Firestore was Used ($typeofAction) in $funcitonName in FirebaseUserRepository");
  }
  User? get currentUser => _auth.currentUser;

  User? get currentUser => _auth.currentUser;
  
  Future<bool> uploadUserModel(UserModel user) async {
    try {
      await FirebaseFirestore.instance
          .collection(usercollectionName)
          .doc(user.userUid)
          .set(user.toJson());
      _logHelper("Set", "uploadUserModel");
      return true;
    } catch (error) {
      log("UserRepository uploadUserModel error: $error");
      return false;
    }
  }

  Future<UserModel?> fetchUser() async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection(usercollectionName)
          .doc(_auth.currentUser!.uid)
          .get();
      _logHelper("Get", "UserModel");
      if (documentSnapshot.exists) {
        UserModel? jsontoUserConverted =
            UserModel.fromJson(documentSnapshot.data() as Map<String, dynamic>);
        return jsontoUserConverted;
      } else {
        return null;
      }
    } catch (error) {
      log("UserRepository uploadUserModel error: $error ");
      return null;
    }
  }
}

final firebaseUserRepository = Provider<FirebaseUserRepository>((ref) {
  return FirebaseUserRepository();
});
