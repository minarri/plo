import 'package:plo/model/erro_handling/error_handling_auth.dart';
import 'package:plo/model/types/enum_type.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FirebaseAuthRepository {
  static const repoName = 'FirebaseAuthRepository';
  final FirebaseAuth firebase = FirebaseAuth.instance;

  // return the currently logged in user. If the user does not exist (non_logged in_user) then returns NULL
  User? getCurrentUser() {
    return firebase.currentUser;
  }

  //sign-up User
  Future<String> signupUser(String email, String password) async {
    try {
      await firebase.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return ReturnTypeENUM.success.toString();
    }
    // case of auth error
    on FirebaseAuthException catch (error) {
      String errorText = ErrorHandlerFunction().signupErrorToString(error);
      return errorText;
    }

    //case of general error

    catch (error) {
      print("Error${error.toString()} in signupUser() in $repoName");
      return error.toString();
    }
  }

  Future<String> signinUser(String email, String password) async {
    try {
      await firebase.signInWithEmailAndPassword(
          email: email, password: password);
      return ReturnTypeENUM.success.toString();
    } on FirebaseAuthException catch (error) {
      String errorText = ErrorHandlerFunction().signInErrorToString(error);
      return errorText;
    } catch (error) {
      print("Error${error.toString()} in signInUser() in $repoName");
      return error.toString();
    }
  }
}

final firebaseAuthRepositoryProvider = Provider<FirebaseAuthRepository>((ref) {
  return FirebaseAuthRepository();
});
