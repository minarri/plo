import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String grade;
  final String major;
  final String nickname;
  final String userProfilePictureURL;

  const User({
    required this.grade,
    required this.major,
    required this.nickname,
    required this.userProfilePictureURL,
  });

  User.initial()
      : grade = 'N/A',
        major = 'N/A',
        nickname = 'N/A',
        userProfilePictureURL = 'N/A';

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      grade: snapshot["grade"],
      major: snapshot["major"],
      nickname: snapshot["nickname"],
      userProfilePictureURL: snapshot["profileImageUrl"],
    );
  }

  Map<String, dynamic> toJson() => {
        "grade": grade,
        "major": major,
        "nickname": nickname,
        "profileImageUrl": userProfilePictureURL,
      };
}
