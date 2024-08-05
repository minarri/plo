import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> uploadProfileImageToStorage(
      String childName, File file, bool isPost) async {
    Reference ref =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(file);

    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  // Future<List<String>?> uploadPostImageToStorage(
  //     String userUid, List<Object> files, String pid) async {
  //   List<String> images = [];
  //   try {
  //     for (int i = 0; i < files.length; i++) {
  //       if (files[i] is String) {
  //         images.add(files[i] as String);
  //         continue;
  //       } else {
  //         File file = files[i] as File;
  //         String photoUid = const Uuid().v1();
  //         final Reference ref = _storage
  //             .ref()
  //             .child('contentImageUrlList')
  //             .child('${userUid}/${pid}/${photoUid}');
  //         try {
  //           log("Starting upload for file $i: ${file.path}");

  //           UploadTask uploadTask = ref.putFile(file);
  //           await uploadTask;
  //           // TaskSnapshot snap = await uploadTask;
  //           log("File uploaded: ${file.path}");

  //           String image = await ref.getDownloadURL();
  //           logToConsole(
  //               "Firebase Storage was used (Url) in uploadPostImageToStorage");

  //           images.add(image);
  //           log("downloadUrls is added to storage");
  //         } catch (uploadError) {
  //           log("Error during file upload or getting download URL: ${uploadError.toString()}");
  //           throw uploadError;
  //         }
  //       }
  //     }
  //     log("All files processed, returning downloadUrls");
  //     return images;
  //   } catch (error) {
  //     // Handle or log the error
  //     log("uploadPostImageToStorage Error: ${error.toString()}");
  //     return null;
  //   }
  // }

  Future<List<String>?> uploadPostImageToStorage(
      String userUid, String pid, List<Object> files) async {
    List<String> photos = [];
    try {
      for (int i = 0; i < files.length; i++) {
        if (files[i] is String) {
          photos.add(files[i] as String);
          continue;
        } else {
          File file = files[i] as File;
          String photoUid = const Uuid().v1();

          // Define the storage reference
          final storageRef = FirebaseStorage.instance
              .ref()
              .child('postImages')
              .child('$userUid/$pid/$photoUid');

          // Upload the file
          UploadTask uploadTask = storageRef.putFile(file);

          // Wait for the upload to complete and get the download URL
          TaskSnapshot taskSnapshot = await uploadTask;
          String downloadUrl = await taskSnapshot.ref.getDownloadURL();

          logToConsole('Firebase storage was used in uploadPhotosToFirebase()');
          photos.add(downloadUrl);
          log(downloadUrl);
        }
      }
      return photos;
    } catch (error) {
      logToConsole("uploadPhotosToFirebase error: ${error.toString()}");
      return null;
    }
  }

  void logToConsole(String message) {
    print(message);
  }
}

final firebaseStorageProvider = Provider<StorageMethods>((ref) {
  return StorageMethods();
});
