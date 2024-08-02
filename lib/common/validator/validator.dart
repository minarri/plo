import 'package:plo/constants/error_message_constants.dart';

class Validator {
  static String? validatePSUEmail(String? email) {
    if (email == null || email.isEmpty) {
      return ErrorMessageConstants.emptyStringError;
    }
    if (RegExp(r'[a-z]{3}[0-9]{1,4}@psu.edu').stringMatch(email) == null) {
      return ErrorMessageConstants.emailFormatError;
    } else {
      return null;
    }
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return ErrorMessageConstants.emptyStringError;
    }
    if (RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$')
            .stringMatch(password) ==
        null) {
      return ErrorMessageConstants.passwordFormatError;
    } else {
      return null;
    }
  }

  static String? isSamePassword(String? password, String? passwordRetype) {
    if (password == null ||
        password.isEmpty ||
        passwordRetype == null ||
        passwordRetype.isEmpty) {
      return ErrorMessageConstants.emptyStringError;
    }
    if (password != passwordRetype) {
      return ErrorMessageConstants.confirmPasswordError;
    } else {
      return null;
    }
  }

  static String? validateNickName(String? nickname) {
    //SelectedFileNotifier profile = SelectedFileNotifier();

    if (nickname == null || nickname.isEmpty) {
      return ErrorMessageConstants.emptyStringError;
    } else {
      return null;
    }
  }

  static String? validateGrade(String? grade) {
    if (grade == null || grade.isEmpty) {
      return ErrorMessageConstants.emptyStringError;
    }
    if (RegExp(r'[0-6]').stringMatch(grade) == null) {
      return ErrorMessageConstants.wrongInputError;
    } else {
      return null;
    }
  }

  static String? validateMajor(String? major) {
    if (major == null || major.isEmpty) {
      return ErrorMessageConstants.emptyStringError;
    } else {
      return null;
    }
  }

  static String? titleValidator(String? title) {
    if (title == null || title.isEmpty) return "제목을 입력하셔야 합니다";
    if (title.length > 50) return "제목은 50자 이내여야 합니다";
    return null;
  }

  static String? contentValidator(String? content) {
    if (content == null || content.isEmpty) return "내용을 입력하셔야 합니다";
    if (content.length > 500) return "내용은 500자 이내여야 합니다";
    return null;
  }

  static String? commentContentValidator(String? commentContent) {
    if (commentContent == null || commentContent.isEmpty) {
      return "내용을 입력하셔야 합니다";
    }
    if (commentContent.length > 100) return "내용은 100자 이내여야 합니다";
    return null;
  }
}
