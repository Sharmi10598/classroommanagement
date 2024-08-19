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

class NewRegistersModel {
  int respCode;
  NewRegisterListModel? registData;
  String exception;
  String? error;
  NewRegistersModel({
    required this.exception,
    required this.respCode,
    this.error,
    required this.registData,
  });
  factory NewRegistersModel.fromJson(
      Map<String, dynamic> json, int statuzCode) {
    // Map<String, dynamic>
    if (statuzCode == 200) {
      // var list = json['registrations'] as List;
      // List<NewRegisterListModel> dataList =
      //     list.map((data) => NewRegisterListModel.fromJson(data)).toList();

      return NewRegistersModel(
          exception: '',
          respCode: statuzCode,
          error: null,
          registData: NewRegisterListModel.fromJson(json['registration']));
    } else {
      return NewRegistersModel(
          exception: json['respDesc'],
          respCode: json['respCode'],
          registData: null);
    }
  }

  factory NewRegistersModel.issue(Map<String, dynamic> exp, int statuzCode) {
    return NewRegistersModel(
        exception: exp['respDesc'], respCode: statuzCode, registData: null
        // data:null
        );
  }
  factory NewRegistersModel.errorExp(dynamic exp, int statuzCode) {
    return NewRegistersModel(
        error: exp['error'],
        exception: '',
        respCode: statuzCode,
        registData: null
        // data:null
        );
  }
  factory NewRegistersModel.issue2(
    int rescode,
    String exp,
  ) {
    return NewRegistersModel(exception: exp, respCode: rescode, registData: null
        // data:null
        );
  }

  factory NewRegistersModel.error(int rescode, String exp) {
    return NewRegistersModel(exception: exp, respCode: rescode, registData: null
        // data:null
        );
  }
}

class NewRegisterListModel {
  int? id;
  int? student;
  int? subject;
//         "id": 459,
//         "student": 5,
//         "subject": 3
  NewRegisterListModel({
    this.id,
    this.student,
    this.subject,
  });

  factory NewRegisterListModel.fromJson(Map<String, dynamic> jsons) {
    // log("gggg::" + jsons.length.toString() + "hhh" + jsons['Id'].toString());
    return NewRegisterListModel(
      id: jsons['id'] ?? 0,
      student: jsons['student'] ?? 0,
      subject: jsons['subject'] ?? 0,
    );
  }
}
