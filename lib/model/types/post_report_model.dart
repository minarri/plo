import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plo/constants/error_replacement_constants.dart';
import 'package:plo/model/types/report_type.dart';

class PostReportModelConstants {
  static const pid = 'pid';
  static const uploadUserUid = 'uploadUserUid';
  static const reportingUserUid = 'reportingUserUid';
  static const uploadTime = 'uploadTime';
  static const reportType = 'reportType';
  static const etcDescription = 'etcDescription';
  static const reportDetail = 'reportDetail';
}

class PostReportModel {
  final String pid;
  final String uploadUserUid;
  final String reportingUserUid;
  final Timestamp uploadTime;
  final ReportType reportType;
  final String? etcDescription;
  final String reportDetail;

  PostReportModel ({
    this.pid = ErrorReplacementConstants.notSetString,
    this.uploadUserUid = ErrorReplacementConstants.notSetString,
    this.reportingUserUid = ErrorReplacementConstants.notSetString,
    required this.uploadTime,
    required this.reportType,
    this.etcDescription = ErrorReplacementConstants.notSetString,
    required this.reportDetail
  });
  Map<String, Object?> toJson() {
    return {
      PostReportModelConstants.pid: pid,
      PostReportModelConstants.uploadUserUid: uploadUserUid,
      PostReportModelConstants.reportingUserUid: reportingUserUid,
      PostReportModelConstants.uploadTime: uploadTime,
      PostReportModelConstants.reportType: reportType,
      PostReportModelConstants.etcDescription: etcDescription,
      PostReportModelConstants.reportDetail: reportDetail,
      
    };
  }

  PostReportModel? fromJson(Map<String, dynamic> json) {
    try {
      return PostReportModel(
        pid: json[PostReportModelConstants.pid] ?? ErrorReplacementConstants.notFoundString,
         uploadUserUid: json[PostReportModelConstants.uploadUserUid] ?? ErrorReplacementConstants.notFoundString,
          reportingUserUid: json[PostReportModelConstants.reportingUserUid] ?? ErrorReplacementConstants.notFoundString,
           uploadTime: json[PostReportModelConstants.pid],
            reportType: json[PostReportModelConstants.pid],
             etcDescription: json[PostReportModelConstants.pid] ?? ErrorReplacementConstants.notFoundString,
              reportDetail: json[PostReportModelConstants.pid] ?? ErrorReplacementConstants.notFoundString,
      );
    } catch (error) {
      return null;
    }
  }
}