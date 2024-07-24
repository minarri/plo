import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plo/common/utils/log_util.dart';
import 'package:plo/constants/firebase_contants.dart';
import 'package:plo/model/types/enum_type.dart';
import 'package:plo/model/types/return_type.dart';
import 'package:plo/model/user.dart' as model;
import 'package:plo/repository/auth_repository.dart';
import 'package:plo/repository/firebasestoroage_respository.dart';
import 'package:plo/repository/image_picker_repository.dart';

Future<model.User> updateEditedUserdataToFirestore(
    String grade, String major, String nickname) async {
  try {
    // Get the reference to the document
    final DocumentReference documentReference = FirebaseFirestore.instance
        .collection(FirebaseConstants.usercollectionName)
        .doc(FirebaseAuth.instance.currentUser!.uid);

    // Update the specific field in the document
    await documentReference.update({
      "grade": grade,
      "major": major,
      "nickname": nickname,
    });
    final updatedUserDoc = await documentReference.get();
    final updatedUser = model.User.fromSnap(updatedUserDoc);

    return updatedUser;
  } catch (error) {
    logToConsole("sendEditedUserdataToFirestore: $error has occurred");
    throw Exception("Failed to update user data: $error");
  }
}

Future<void> deleteProfilePictureFromStorage() async {
  try {
    FirebaseStorage.instance
        .ref("profilePics/${FirebaseAuth.instance.currentUser!.uid}")
        .delete();
  } catch (error) {
    logToConsole("deleteProfilePictureFromStorage: $error has occured");
  }
}

Future<void> deleteUserdataFromFirestore() async {
  try {
    FirebaseFirestore.instance
        .collection(FirebaseConstants.usercollectionName)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .delete();
  } catch (error) {
    logToConsole("deleteUserdataFromFireStore: $error has occured");
  }
}

Future<String> deleteUserAccount(WidgetRef ref) async {
  try {
    await deleteProfilePictureFromStorage();

    await deleteUserdataFromFirestore();

    final authMethods = ref.read(authRepository);
    await authMethods.deleteUserAccount(); //FIXME;

    return ReturnTypeENUM.success.toString();
  } on FirebaseAuthException catch (e) {
    logToConsole("deleteUserAccount: ${e.code} has occured");
    if (e.code == 'auth/requires-recent-login') {
      return e.code.toString();
    }
    return e.code.toString();
  } catch (e) {
    logToConsole("deleteUserAccount: $e has occured");
    return ReturnTypeENUM.failure.toString();
  }
}

Future<model.User> getUserData() async {
  try {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection(FirebaseConstants.usercollectionName)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    model.User user = model.User.fromSnap(snap);

    return user;
  } catch (error) {
    logToConsole("getUserData: $error has occured");
    return model.User.initial();
  }
}

Future<void> getPosts(String collectionName, DocumentSnapshot? lastDocument,
    List<DocumentSnapshot> documentList) async {
  try {
    Query query = FirebaseFirestore.instance
        .collection(collectionName)
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .orderBy('post_time', descending: true)
        .limit(10);

    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }

    QuerySnapshot querySnapshot = await query.get();
    if (querySnapshot.docs.isNotEmpty) {
      lastDocument = querySnapshot.docs[querySnapshot.docs.length - 1];

      documentList.addAll(querySnapshot.docs);
    }
  } catch (error) {
    logToConsole("getPosts: $error has occured");
  }
}

Future<void> selectImage(ImageSource source, File? image) async {
  final pickedImage = ImagePickerRepository();
  ReturnType result;
  if (source == ImageSource.camera) {
    result = await pickedImage.pickImageFromCamera();
  } else {
    result = await pickedImage.pickImageFromGallery();
  }
  if (result is SuccessReturnType && result.data != null) {
    File file = result.data;

    image = file;
  } else if (result is ErrorReturnType) {
    logToConsole(result.message!);
  }
}

void uploadChangedPictureToStorage(
    String isCamera, File? image, String photoUrl) async {
  try {
    if (isCamera == "Camera") {
      await selectImage(ImageSource.camera, image);
    } else {
      await selectImage(ImageSource.gallery, image);
    }

    photoUrl = await StorageMethods()
        .uploadProfileImageToStorage('profilePics', image!, false);
    // Get the reference to the document
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid);

    // Update the specific field in the document
    await documentReference.update({"profileImageUrl": photoUrl});
  } catch (error) {
    logToConsole("sendChangedPictureToStorage: $error has occured");
  }
}
