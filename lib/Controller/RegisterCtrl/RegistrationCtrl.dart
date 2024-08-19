// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamonapp/Constant/ConstantRoutes.dart';
import 'package:hamonapp/Constant/Screen.dart';
import 'package:hamonapp/DBHelper/DBOperations.dart';
import 'package:hamonapp/Models/SubModels.dart';
import 'package:sqflite/sqlite_api.dart';

import '../../Constant/Configuration.dart';
import '../../DBHelper/DBHelpers.dart';
import '../../Models/NewRegisterMode.dart';
import '../../Models/RegisterModel.dart';
import '../../Models/StudentsModel.dart';
import '../../Pages/StudentsPage/Widgets/StudentsList.dart';
import '../../Pages/SubjectsPage/Widgets/SubList.dart';
import '../../Services/RegistrationApi/DeleteRegisterApi.dart';
import '../../Services/RegistrationApi/GetRegisterApi.dart';
import '../../Services/RegistrationApi/PostRegisterApi.dart';

class RegisterController extends ChangeNotifier {
  List<TextEditingController> mycontroller =
      List.generate(20, (i) => TextEditingController());
  List<GlobalKey<FormState>> formkey =
      List.generate(20, (i) => GlobalKey<FormState>());

  init(
    BuildContext context,
  ) {
    clearall();
    callGetRegListApi(context);
  }

  clearall() {
    mycontroller = List.generate(20, (i) => TextEditingController());
    registtData = [];
    isLoading = false;
    notifyListeners();
  }

  Config config = Config();
  bool isLoading = false;
  String errorMsg = '';

  int? studid;
  int? registerid;

  int? subsId;

  List<GetRegisterListModel> registtData = [];
  NewRegisterListModel? registtDetData;

  callPostNewRegApi(BuildContext context, ThemeData theme) {
    isLoading = true;
    registtDetData = null;
    PostRegistrationApi.getData(studid!, subsId!).then((value) async {
      if (value.respCode >= 200 && value.respCode <= 210) {
        registtDetData = value.registData!;

        callGetRegListApi(context);
        Get.offAllNamed(ConstantRoutes.register);
        SubjectsListsState.iscamefromReg = false;
        SubjectsListsState.iscamefromCls = false;
        StudentListsState.iscamefromReg = false;
        isLoading = false;
        notifyListeners();
      } else if (value.respCode >= 400 && value.respCode <= 410) {
        errorMsg = value.exception;
        getAlertMessage(context, theme, value.error!);
        mycontroller[0].text = '';
        mycontroller[1].text = '';

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

  GetStudentListModel stddListData = GetStudentListModel();
  GetSubListModel subListData = GetSubListModel();

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

  callGetRegListApi(
    BuildContext context,
  ) async {
    final theme = Theme.of(context);
    registtData = [];
    isLoading = true;
    await GetRegistrationApi.getData().then((value) async {
      if (value.respCode >= 200 && value.respCode <= 210) {
        registtData = value.registData;
        isLoading = false;
        notifyListeners();
      } else if (value.respCode >= 400 && value.respCode <= 410) {
        errorMsg = value.exception;
        getAlertMessage(context, theme, value.error!);

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
      }
      isLoading = false;
    });
    notifyListeners();
  }

  String delMessage = '';
  String get getdelMessage => delMessage;

  callDeletegetListApi(
    BuildContext context,
  ) async {
    final theme = Theme.of(context);
    isLoading = true;
    delMessage = '';
    log('registerid::$registerid');
    await DelRegistrationApi.getData(registerid!).then((value) async {
      if (value.code! >= 200 && value.code! <= 210) {
        // delMessage = value.message!;
        delMessage = 'Registration Deleted';

        callGetRegListApi(context);
        Get.offAllNamed(ConstantRoutes.register);
        isLoading = false;
        Future.delayed(Duration(seconds: 5)).then((value) {
          delMessage = '';
          notifyListeners();
        });
        notifyListeners();
      } else if (value.code! >= 400 && value.code! <= 410) {
        errorMsg = value.message!;
        Get.back();
        getAlertMessage(context, theme, value.message!);
        isLoading = false;

        notifyListeners();
      } else {
        bool? noNetbool = await config.haveNoInterNet();

        if (noNetbool == false) {
          Get.back();
          getAlertMessage(context, theme, value.message!);
          notifyListeners();
        } else {
          Get.back();
          getAlertMessage(context, theme, 'Check Your Internet..!!');
          notifyListeners();
        }
      }
      isLoading = false;
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
            SizedBox(
              height: Screens.padingHeight(context) * 0.01,
            ),
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

  deleteAlertMessage(
    BuildContext context,
    ThemeData theme,
  ) async {
    await Get.defaultDialog(
        barrierDismissible: false,
        title: 'Delete',
        content: Column(
          children: [
            const Text('Do you want to delete'),
            SizedBox(
              height: Screens.padingHeight(context) * 0.005,
            ),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      padding:
                          EdgeInsets.only(left: Screens.width(context) * 0.05),
                      child: TextButton(
                          onPressed: () async {
                            Get.back();
                          },
                          child: Text('No',
                              style: theme.textTheme.bodyLarge
                                  ?.copyWith(color: Colors.blue)))),
                  VerticalDivider(
                    color: Colors.black,
                    thickness: 0.4,
                  ),
                  Container(
                      padding:
                          EdgeInsets.only(right: Screens.width(context) * 0.05),
                      child: TextButton(
                          onPressed: () async {
                            callDeletegetListApi(context);
                          },
                          child: Text('Yes',
                              style: theme.textTheme.bodyLarge
                                  ?.copyWith(color: Colors.blue)))),
                ],
              ),
            )
          ],
        ));
    notifyListeners();
  }
}
