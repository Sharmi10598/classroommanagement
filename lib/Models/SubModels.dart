// {"subjects":[{"credits":10,"id":1,"name":"History","teacher":"Brenda Miller"},
//{"credits":15,"id":2,"name":"Mathematics","teacher":"Brenda Miller"},
//{"credits":12,"id":3,"name":"Social Science","teacher":"Jamie Holden"},
//{"credits":15,"id":4,"name":"Physics","teacher":"Adam Ingram"},
//{"credits":10,"id":6,"name":"Biology","teacher":"Pamela Fowler"}]}

import 'dart:convert';

import '../DBHelper/DBModel/SubTable.dart';

class GetSubModel {
  int respCode;
  List<GetSubListModel> subListData;
  String exception;
  GetSubModel({
    required this.exception,
    required this.respCode,
    required this.subListData,
  });
  factory GetSubModel.fromJson(Map<String, dynamic> json, int statuzCode) {
    // Map<String, dynamic>
    if (statuzCode == 200) {
      var list = json['subjects'] as List;
      List<GetSubListModel> dataList =
          list.map((data) => GetSubListModel.fromJson(data)).toList();

      return GetSubModel(
        exception: '',
        respCode: statuzCode,
        subListData: dataList,
      );
      // GetAuditActionMainDataModel.fromJson(json['data']));
    } else {
      return GetSubModel(
          exception: json['respDesc'],
          respCode: json['respCode'],
          subListData: []);
    }
  }

  factory GetSubModel.issue(
      int rescode, Map<String, dynamic> exp, int statuzCode) {
    return GetSubModel(
        exception: exp['respDesc'], respCode: statuzCode, subListData: []
        // data: []
        );
  }

  factory GetSubModel.issue2(
    int rescode,
    String exp,
  ) {
    return GetSubModel(exception: exp, respCode: rescode, subListData: []);
  }

  factory GetSubModel.error(int rescode, String exp) {
    return GetSubModel(exception: exp, respCode: rescode, subListData: []
        // data: []
        );
  }
}

class GetSubListModel {
  int? credits;
  int? id;
  String? teacher;
  String? name;

  GetSubListModel({
    this.credits,
    this.id,
    this.teacher,
    this.name,
  });

  factory GetSubListModel.fromJson(Map<String, dynamic> jsons) {
//{"credits":8,"id":5,"name":"Chemistry","teacher":"Erin Walsh"},

    // log("gggg::" + jsons.length.toString() + "hhh" + jsons['Id'].toString());
    return GetSubListModel(
      credits: jsons['credits'],
      id: jsons['id'] ?? '',
      teacher: jsons['teacher'] ?? '',
      name: jsons['name'] ?? 0,
    );
  }
  Map<String, Object?> toMap() => {
        SubListDBT.id: id,
        SubListDBT.teacher: teacher,
        SubListDBT.credits: credits,
        SubListDBT.name: name,
      };
}
