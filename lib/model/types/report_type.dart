class ReportTypeFieldNameConstants {
  static const postIssue = "postIssue";
  static const prohibitedPosts = "prohibitedPosts";
  static const falseInformation = "falseInformation";
  static const spam = "spam";
  static const fraud = "fraud";
  static const etc = "etc";
}

enum ReportType {
  postIssue,
  prohibitedPosts,
  falseInformation,
  spam,
  fraud,
  etc;


  @override

  String toString() {
    switch(this) {
      case ReportType.postIssue:
      return ReportTypeFieldNameConstants.postIssue;
      case ReportType.prohibitedPosts:
      return ReportTypeFieldNameConstants.prohibitedPosts;
      case ReportType.falseInformation:
      return ReportTypeFieldNameConstants.falseInformation;
      case ReportType.spam:
      return ReportTypeFieldNameConstants.spam;
      case ReportType.fraud:
      return ReportTypeFieldNameConstants.fraud;
      case ReportType.etc:
      return ReportTypeFieldNameConstants.etc;
    }
  }
  String getDescription() {
    switch(this)  {
      case ReportType.postIssue: 
      return "게시물 에러가 있습니다";
      case ReportType.prohibitedPosts:
      return "게시물 정책에 위반되는 게시물입니다";
      case ReportType.falseInformation:
      return "부 정확하거나 사실이 아닌 게시물입니다";
      case ReportType.spam:
      return "스팸 게시물이고 광고성 게시물입니다.";
      case ReportType.fraud:
      return "사기가 의심되는 게시물입니다";
      case ReportType.etc:
      return "기타 이유";
    }
  }
  static stringToCategory(String string) {
    switch(string) {
      case ReportTypeFieldNameConstants.postIssue:
      return ReportType.postIssue;
      case ReportTypeFieldNameConstants.prohibitedPosts:
      return ReportType.prohibitedPosts;
      case ReportTypeFieldNameConstants.falseInformation:
      return ReportType.falseInformation;
      case ReportTypeFieldNameConstants.spam:
      return ReportType.spam;
      case ReportTypeFieldNameConstants.fraud:
      return ReportType.fraud;
      case ReportTypeFieldNameConstants.etc:
      return ReportType.etc;
      default:
      return ReportType.etc;
    }
  }
}

enum ReportDescription {
  description;
}