import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamonapp/Constant/Screen.dart';
import 'package:provider/provider.dart';

import '../../../Controller/RegisterCtrl/RegistrationCtrl.dart';
import '../../../Controller/StudentController/StudentControllers.dart';
import '../../RegistrationPage/Widgets/NewRegisterPage.dart';
import 'StudentsDetails.dart';

class StudentLists extends StatefulWidget {
  const StudentLists({super.key});

  @override
  State<StudentLists> createState() => StudentListsState();
}

class StudentListsState extends State<StudentLists> {
  static bool iscamefromReg = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(
            top: Screens.padingHeight(context) * 0.03,
          ),
          height: Screens.padingHeight(context) * 0.8,
          child: context.watch<stdCtrl>().isLoading == true &&
                  context.watch<stdCtrl>().stddListData.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                )
              : context.watch<stdCtrl>().stddListData.isEmpty
                  ? Center(
                      child: Text('No Data Found'),
                    )
                  : ListView.builder(
                      itemCount: context.watch<stdCtrl>().stddListData.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 0,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                context.read<stdCtrl>().fetchStudentDet(index);
                                if (iscamefromReg == true) {
                                  context.read<RegisterController>().studid =
                                      context
                                          .read<stdCtrl>()
                                          .stddListData[index]
                                          .id;

                                  context
                                          .read<RegisterController>()
                                          .mycontroller[0]
                                          .text =
                                      context
                                          .read<stdCtrl>()
                                          .stddListData[index]
                                          .name!;

                                  StudentListsState.iscamefromReg = false;
                                  Get.back();
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const StdDetails()));
                                }
                              });
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.white,
                                    border: Border.all(color: Colors.black26)),
                                padding: EdgeInsets.all(
                                    Screens.padingHeight(context) * 0.01),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: Screens.width(context) * 0.65,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(context
                                                  .watch<stdCtrl>()
                                                  .stddListData[index]
                                                  .name!),
                                              Text(context
                                                  .watch<stdCtrl>()
                                                  .stddListData[index]
                                                  .email!),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          width: Screens.width(context) * 0.2,
                                          child: Text(
                                              'Age : ${context.watch<stdCtrl>().stddListData[index].age}'),
                                        )
                                      ],
                                    ),
                                  ],
                                )),
                          ),
                        );
                      }),
        ),
      ],
    );
  }
}
