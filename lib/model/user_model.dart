import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plo/constants/error_replacement_constants.dart';

class UserModelNameConstants {
  static const userUid = 'userUid';
  static const email = 'email';
  static const userNickname = 'nickname';
  static const userCreatedDate = 'userCreatedDate';
  static const grade = 'grade';
  static const major = 'major';
  static const profileImageUrl = "profileImageUrl";
  static const likedPosts = "likedPosts";
  static const blockedUsers = "blockedUsers";
}

class UserModel {
  final String userUid;
  final String email;
  final String userNickname;
  final Timestamp? userCreatedDate;
  final String major;
  final String grade;
  final String profileImageUrl;
  final List<String> likedPosts;
  final List<String> blockedUsers;
  UserModel(
      {this.userUid = ErrorReplacementConstants.notSetString,
      this.email = ErrorReplacementConstants.notSetString,
      this.userCreatedDate,
      this.blockedUsers = const [],
      this.userNickname = ErrorReplacementConstants.notFoundString,
      this.grade = ErrorReplacementConstants.notFoundString,
      this.major = ErrorReplacementConstants.notFoundString,
      this.profileImageUrl = ErrorReplacementConstants.notFoundString,
      this.likedPosts = const []});
  Map<String, dynamic> toJson() {
    return {
      UserModelNameConstants.userUid: userUid,
      UserModelNameConstants.email: email,
      UserModelNameConstants.userCreatedDate: userCreatedDate,
      UserModelNameConstants.userNickname: userNickname,
      UserModelNameConstants.grade: grade,
      UserModelNameConstants.major: major,
      UserModelNameConstants.profileImageUrl: profileImageUrl,
      UserModelNameConstants.likedPosts: likedPosts,
      UserModelNameConstants.blockedUsers: blockedUsers,
    };
  }

  static UserModel? fromJson(Map<String, dynamic> json) {
    try {
      final List<String> likedPostsLists =
          json[UserModelNameConstants.likedPosts] == null
              ? const []
              : (json[UserModelNameConstants.likedPosts] as List<dynamic>)
                  .map((e) => e.toString())
                  .toList();
      final List<String> blockedUsersList =
          json[UserModelNameConstants.blockedUsers] == null
              ? const []
              : (json[UserModelNameConstants.blockedUsers] as List<dynamic>)
                  .map((e) => e.toString())
                  .toList();
      return UserModel(
          userUid: json[UserModelNameConstants.userUid] ??
              ErrorReplacementConstants.notFoundString,
          email: json[UserModelNameConstants.email] ??
              ErrorReplacementConstants.notFoundString,
          userCreatedDate: json[UserModelNameConstants.userCreatedDate],
          userNickname: json[UserModelNameConstants.userNickname] ??
              ErrorReplacementConstants.notFoundString,
          grade: json[UserModelNameConstants.grade] ??
              ErrorReplacementConstants.notFoundString,
          major: json[UserModelNameConstants.major] ??
              ErrorReplacementConstants.notFoundString,
          profileImageUrl: json[UserModelNameConstants.profileImageUrl] ??
              ErrorReplacementConstants.notFoundString,
          likedPosts: likedPostsLists,
          blockedUsers: blockedUsersList);
    } catch (error) {
      print("Error while converting json to User Object : ${error.toString()}");
      return null;
    }
  }

  UserModel copyWith(
      {String? userUid,
      String? email,
      Timestamp? userCreatedDate,
      String? userNickname,
      String? grade,
      String? major,
      String? profileImageUrl,
      List<String>? blockedUsers,
      List<String>? likedPosts}) {
    return UserModel(
      userUid: userUid ?? this.userUid,
      email: email ?? this.email,
      userCreatedDate: userCreatedDate ?? this.userCreatedDate,
      userNickname: userNickname ?? this.userNickname,
      grade: grade ?? this.grade,
      major: major ?? this.major,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      likedPosts: likedPosts ?? this.likedPosts,
      blockedUsers: blockedUsers ?? this.blockedUsers,
    );
  }
}
