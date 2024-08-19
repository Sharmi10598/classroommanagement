import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamonapp/DBHelper/DBOperations.dart';
import 'package:sqflite/sqlite_api.dart';

import '../../Constant/Configuration.dart';
import '../../DBHelper/DBHelpers.dart';
import '../../Models/SubModels.dart';
import '../../Pages/SubjectsPage/Widgets/SubList.dart';
import '../../Services/SubjectApi.dart';

class SubjectsCtrls extends ChangeNotifier {
  init(
    BuildContext context,
  ) {
    clearAllData();
    callGetStudentList(
      context,
    );
  }

  clearAllData() {
    isLoading = false;
    errorMsg = '';
    subListtData = [];
    notifyListeners();
  }

  Config config = Config();
  bool isLoading = false;
  String errorMsg = '';

  List<GetSubListModel> subListtData = [];
  GetSubListModel fetchSubListData = GetSubListModel();
  fetchSubDet(int index) {
    fetchSubListData = GetSubListModel(
        credits: subListtData[index].credits,
        name: subListtData[index].name,
        id: subListtData[index].id,
        teacher: subListtData[index].teacher);
    notifyListeners();
  }

  callGetStudentList(
    BuildContext context,
  ) async {
    final theme = Theme.of(context);
    Database db = (await DBHelper.getInstance())!;
    isLoading = true;

    subListtData = [];
    await GetSubListApi.getData().then((value) async {
      if (value.respCode >= 200 && value.respCode <= 210) {
        subListtData = value.subListData;
        DBOperation.truncateSub(db);
        DBOperation.insertsubject(db, subListtData);
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
