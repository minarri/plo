import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:plo/constants/firebase_contants.dart';
import 'package:plo/model/email_response_model.dart';
import 'package:plo/model/erro_handling/error_handling_auth.dart';
import 'package:plo/services/api_service.dart';

typedef EitherModel<T> = Either<String, T>;

Future<EitherModel<LoginResponseModel>> sendVerifyCodeToEmail(
    TextEditingController email) async {
  try {
    LoginResponseModel res = await EmailAPIService.otpLogin(email.text);
    return right(res);
  } on FirebaseAuthException catch (e) {
    return left(ErrorHandlerFunction().signupErrorToString(e));
  } catch (e) {
    return left(e.toString());
  }
}

Future<EitherModel<LoginResponseModel>> verifyVerifyCode(
    TextEditingController email, String otpHash, String userVerifyCode) async {
  try {
    LoginResponseModel res =
        await EmailAPIService.verifyOTP(email.text, otpHash, userVerifyCode);
    return right(res);
  } catch (e) {
    return left(e.toString());
  }
}

Future<EitherModel<bool>> checkDuplicate(String nickname) async {
  try {
    //콜렉션 users안의 document들 중에서 필드 이름이 nickname이고 그 value가 parameter와 같은 document들만 있는 query
    QuerySnapshot dupQuery = await FirebaseFirestore.instance
        .collection(FirebaseConstants.usercollectionName)
        .where('nickname', isEqualTo: nickname)
        .get();

    return right(dupQuery.docs.isEmpty);
  } on FirebaseAuthException catch (e) {
    return left(ErrorHandlerFunction().signupErrorToString(e));
  } catch (e) {
    return left(e.toString());
  }
}
/*
Future<bool> checkIfEmailInUse(String emailAddress) async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password)
    return true;
  } catch (e) {
    print(e.toString());
    switch (e.toString()) {
      case "email-already-in-use":
        return true;
    }
    return true;
  }
}
*/