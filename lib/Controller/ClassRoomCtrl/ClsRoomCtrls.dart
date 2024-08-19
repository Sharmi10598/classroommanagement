import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import '../../Constant/Configuration.dart';
import '../../DBHelper/DBHelpers.dart';
import '../../DBHelper/DBOperations.dart';
import '../../Models/ClassRoomsModel.dart';
import '../../Models/StudentsModel.dart';
import '../../Models/SubModels.dart';
import '../../Services/ClassRoomsApi.dart';

class ClassRoomController extends ChangeNotifier {
  init(
    BuildContext context,
  ) {
    clearAllData();
    callGetClassList(
      context,
    );
    // getAllSub();
  }

  clearAllData() {
    isLoading = false;
    errorMsg = '';
    clsListtData = [];
    layoutt = '';
    subListData = null;
    subName = '';
    teacherName = '';
    updatedMsg = '';
    notifyListeners();
  }

  String layoutt = '';
  String updatedMsg = '';

  bool subupdate = false;
  Config config = Config();
  bool isLoading = false;
  String errorMsg = '';

  List<GetClsRoomListModel> clsListtData = [];
  GetClsRoomListModel fetchClsListData = GetClsRoomListModel();
  fetchClassDet(int index) {
    fetchClsListData = GetClsRoomListModel(
        layout: clsListtData[index].layout,
        name: clsListtData[index].name,
        id: clsListtData[index].id,
        size: clsListtData[index].size);
    notifyListeners();
  }

  getnameList(String name, String teach) {
    subName = name;
    teacherName = teach;
    notifyListeners();
  }

  callGetClassList(
    BuildContext context,
  ) async {
    final theme = Theme.of(context);
    clsListtData = [];
    isLoading = true;
    await GetClsRoomsListApi.getData().then((value) async {
      if (value.respCode >= 200 && value.respCode <= 210) {
        clsListtData = value.clsRoomListData;
        isLoading = false;
        notifyListeners();
      } else if (value.respCode >= 400 && value.respCode <= 410) {
        errorMsg = value.exception;
        getAlertMessage(context, theme, value.exception);

        isLoading = false;
        notifyListeners();
      } else {
        bool? noNetbool = await config.haveNoInterNet();

        if (noNetbool == false) {
          getAlertMessage(context, theme, value.exception);
          notifyListeners();
        } else {
          getAlertMessage(context, theme, 'Check Your Internet..!!');

          notifyListeners();
        }
        isLoading = false;
      }
    });
    notifyListeners();
  }

  String subName = '';
  String teacherName = '';
  GetStudentListModel stddListData = GetStudentListModel();
  GetSubListModel? subListData = GetSubListModel();
  fetchSubjectDet(GetSubListModel subDet) {
    subListData = GetSubListModel(
        credits: subDet.credits,
        name: subDet.name,
        id: subDet.id,
        teacher: subDet.teacher);
    notifyListeners();
    log('subListDatasubListData::${subListData!.name}');
    notifyListeners();
  }

  getAllSub() async {
    Database db = (await DBHelper.getInstance())!;
    subListData = null;
    List<Map<String, Object?>> getSubjectDet = await DBOperation.getSubject(
      db,
    );

    if (getSubjectDet.isNotEmpty) {
      subListData = GetSubListModel(
          credits: int.parse(getSubjectDet[0]['Credits'].toString()),
          id: int.parse(getSubjectDet[0]['Id'].toString()),
          name: getSubjectDet[0]['Name'].toString(),
          teacher: getSubjectDet[0]['Teacher'].toString());
      notifyListeners();
    }
    notifyListeners();
  }

  getStudnadSubDetails(int stdid, int subid) async {
    Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getStudentDet =
        await DBOperation.getStudentId(db, stdid);
    List<Map<String, Object?>> getSubjectDet =
        await DBOperation.getSubjectid(db, subid);
    for (var i = 0; i < getStudentDet.length; i++) {
      stddListData = GetStudentListModel(
        age: int.parse(getStudentDet[i]['Age'].toString()),
        email: getStudentDet[i]['Email'].toString(),
        name: getStudentDet[i]['Name'].toString(),
        id: int.parse(getStudentDet[i]['Id'].toString()),
      );
      notifyListeners();
    }

    for (var i = 0; i < getSubjectDet.length; i++) {
      subListData = GetSubListModel(
          credits: int.parse(getSubjectDet[i]['Credits'].toString()),
          id: int.parse(getSubjectDet[i]['Id'].toString()),
          name: getSubjectDet[i]['Name'].toString(),
          teacher: getSubjectDet[i]['Teacher'].toString());
    }
  }

  getAlertMessage(BuildContext contenxt, ThemeData theme, String msgg) async {
    await Get.defaultDialog(
        barrierDismissible: false,
        title: 'Message',
        content: Column(
          children: [
            Text(msgg),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    foregroundColor: Colors.white,
                    backgroundColor: theme.primaryColor),
                onPressed: () async {
                  Get.back();
                },
                child: const Text(' Ok '))
          ],
        ));
  }
}
