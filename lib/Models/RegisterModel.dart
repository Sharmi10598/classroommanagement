// {
//     "registrations": [
//         {
//             "id": 459,
//             "student": 5,
//             "subject": 3
//         }
//     ]
// }

import 'dart:convert';

import 'ErrorModelSl.dart';

class GetRegisterModel {
  int respCode;
  List<GetRegisterListModel> registData;
  String exception;
  String? error;
  GetRegisterModel({
    required this.exception,
    required this.respCode,
    this.error,
    required this.registData,
  });
  factory GetRegisterModel.fromJson(Map<String, dynamic> json, int statuzCode) {
    // Map<String, dynamic>
    if (statuzCode == 200) {
      var list = json['registrations'] as List;
      List<GetRegisterListModel> dataList =
          list.map((data) => GetRegisterListModel.fromJson(data)).toList();

      return GetRegisterModel(
          exception: '',
          respCode: statuzCode,
          error: null,
          registData: dataList);
      // GetAuditActionMainDataModel.fromJson(json['data']));
    } else {
      return GetRegisterModel(
          exception: json['respDesc'],
          respCode: json['respCode'],
          registData: []);
    }
  }

  factory GetRegisterModel.issue(Map<String, dynamic> exp, int statuzCode) {
    return GetRegisterModel(
        exception: exp['respDesc'], respCode: statuzCode, registData: []
        // data:[]
        );
  }
  factory GetRegisterModel.errorExp(dynamic exp, int statuzCode) {
    return GetRegisterModel(
        error: exp['error'], exception: '', respCode: statuzCode, registData: []
        // data:[]
        );
  }
  factory GetRegisterModel.issue2(
    int rescode,
    String exp,
  ) {
    return GetRegisterModel(exception: exp, respCode: rescode, registData: []
        // data:[]
        );
  }

  factory GetRegisterModel.error(int rescode, String exp) {
    return GetRegisterModel(exception: exp, respCode: rescode, registData: []
        // data:[]
        );
  }
}

class GetRegisterListModel {
  int? id;
  int? student;
  int? subject;
//         "id": 459,
//         "student": 5,
//         "subject": 3
  GetRegisterListModel({
    this.id,
    this.student,
    this.subject,
  });

  factory GetRegisterListModel.fromJson(Map<String, dynamic> jsons) {
    // log("gggg::" + jsons.length.toString() + "hhh" + jsons['Id'].toString());
    return GetRegisterListModel(
      id: jsons['id'] ?? 0,
      student: jsons['student'] ?? 0,
      subject: jsons['subject'] ?? 0,
    );
  }
}
