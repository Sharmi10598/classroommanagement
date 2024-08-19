import 'dart:convert';

class GetClassRoomModel {
  int respCode;
  List<GetClsRoomListModel> clsRoomListData;
  String exception;
  GetClassRoomModel({
    required this.exception,
    required this.respCode,
    required this.clsRoomListData,
  });
  factory GetClassRoomModel.fromJson(
      Map<String, dynamic> json, int statuzCode) {
    // Map<String, dynamic>
    if (statuzCode == 200) {
      var list = json['classrooms'] as List;
      List<GetClsRoomListModel> dataList =
          list.map((data) => GetClsRoomListModel.fromJson(data)).toList();

      return GetClassRoomModel(
        exception: '',
        respCode: statuzCode,
        clsRoomListData: dataList,
      );
      // GetAuditActionMainDataModel.fromJson(json['data']));
    } else {
      return GetClassRoomModel(
          exception: json['respDesc'],
          respCode: json['respCode'],
          clsRoomListData: []);
    }
  }

  factory GetClassRoomModel.issue(
      int rescode, Map<String, dynamic> exp, int statuzCode) {
    return GetClassRoomModel(
        exception: exp['respDesc'], respCode: statuzCode, clsRoomListData: []
        // data: []
        );
  }

  factory GetClassRoomModel.issue2(
    int rescode,
    String exp,
  ) {
    return GetClassRoomModel(exception: exp, respCode: rescode, clsRoomListData: []
        // data: []
        );
  }

  factory GetClassRoomModel.error(int rescode, String exp) {
    return GetClassRoomModel(exception: exp, respCode: rescode, clsRoomListData: []
        // data: []
        );
  }
}

class GetClsRoomListModel {
  String? layout;
  int? id;
  int? size;
  String? name;

  GetClsRoomListModel({
    this.layout,
    this.id,
    this.size,
    this.name,
  });

  factory GetClsRoomListModel.fromJson(Map<String, dynamic> jsons) {
    // {"classrooms":[{"id":1,"layout":"classroom","name":"LightSeaGreen","size":21},

    return GetClsRoomListModel(
      layout: jsons['layout'],
      id: jsons['id'] ?? '',
      size: jsons['size'] ?? '',
      name: jsons['name'] ?? 0,
    );
  }
}
