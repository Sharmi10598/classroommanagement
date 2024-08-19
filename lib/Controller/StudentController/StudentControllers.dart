import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamonapp/DBHelper/DBOperations.dart';
import 'package:sqflite/sqflite.dart';

import '../../Constant/Configuration.dart';
import '../../DBHelper/DBHelpers.dart';
import '../../Models/StudentsModel.dart';

import '../../Services/StudentApi.dart';

class stdCtrl extends ChangeNotifier {
  init(BuildContext context) {
    clearAllData();
    callGetStudentList(context);
  }

  clearAllData() {
    stddListData = [];
    isLoading = false;

    notifyListeners();
  }

  List<GetStudentListModel> stddListData = [];
  List<GetStudentListModel> getStddListData = [];

  GetStudentListModel? fetchStdListData = GetStudentListModel();

  String errorMsg = '';
  Config config = Config();
  bool isLoading = false;

  fetchStudentDet(int index) {
    fetchStdListData = GetStudentListModel(
        age: stddListData[index].age,
        name: stddListData[index].name,
        id: stddListData[index].id,
        email: stddListData[index].email);
    notifyListeners();
  }

  callGetStudentList(
    BuildContext context,
  ) async {
    Database db = (await DBHelper.getInstance())!;

    final theme = Theme.of(context);
    isLoading = true;
    stddListData = [];

    await GetStdListApi.getData().then((value) async {
      if (value.respCode >= 200 && value.respCode <= 210) {
        stddListData = value.stdListData;
        DBOperation.truncateStd(db);
        DBOperation.insertStudent(db, stddListData);
        isLoading = false;

        notifyListeners();
      } else if (value.respCode >= 400 && value.respCode <= 410) {
        errorMsg = value.exception;
        // apiResponseDialog(context, theme, value.exception);
        await getAlertMessage(context, theme, value.exception);

        isLoading = false;
        notifyListeners();
      } else {
        bool? noNetbool = await config.haveNoInterNet();

        if (noNetbool == false) {
          await getAlertMessage(context, theme, value.exception);

          notifyListeners();
        } else {
          await getAlertMessage(context, theme, 'Check Your ..!!');

          notifyListeners();
        }
        isLoading = false;
      }
      notifyListeners();
    });
    notifyListeners();
  }

  getAlertMessage(BuildContext context, ThemeData theme, String msgg) async {
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
    notifyListeners();
  }
}
