import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamonapp/Constant/Screen.dart';
import 'package:hamonapp/Controller/ClassRoomCtrl/ClsRoomCtrls.dart';
import 'package:hamonapp/Controller/RegisterCtrl/RegistrationCtrl.dart';
import 'package:provider/provider.dart';

import '../../../Controller/SubjectController/SubjectCtrls.dart';
import 'SubDetails.dart';

class SubjectsLists extends StatefulWidget {
  const SubjectsLists({super.key});

  @override
  State<SubjectsLists> createState() => SubjectsListsState();
}

class SubjectsListsState extends State<SubjectsLists> {
  static bool iscamefromReg = false;
  static bool iscamefromCls = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(
            top: Screens.padingHeight(context) * 0.03,
          ),
          height: Screens.padingHeight(context) * 0.8,
          child: context.watch<SubjectsCtrls>().isLoading == true &&
                  context.watch<SubjectsCtrls>().subListtData.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                )
              : context.watch<SubjectsCtrls>().subListtData.isEmpty
                  ? const Center(child: Text('No Data Found..!!'))
                  : ListView.builder(
                      itemCount:
                          context.watch<SubjectsCtrls>().subListtData.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 0,
                          child: GestureDetector(
                            onTap: () {
                              log('hhhhhhhh::$iscamefromCls');
                              context.read<SubjectsCtrls>().fetchSubDet(index);

                              if (iscamefromReg == true) {
                                setState(() {
                                  context.read<RegisterController>().subsId =
                                      context
                                          .read<SubjectsCtrls>()
                                          .subListtData[index]
                                          .id;
                                  context
                                          .read<RegisterController>()
                                          .mycontroller[1]
                                          .text =
                                      context
                                          .read<SubjectsCtrls>()
                                          .subListtData[index]
                                          .name!;
                                  SubjectsListsState.iscamefromReg = false;
                                  SubjectsListsState.iscamefromCls = false;
                                  Get.back();
                                });
                              } else if (iscamefromCls == true) {
                                log('xxxxxx1111');
                                setState(() {
                                  context
                                      .read<ClassRoomController>()
                                      .getnameList(
                                          context
                                              .read<SubjectsCtrls>()
                                              .subListtData[index]
                                              .name!,
                                          context
                                              .read<SubjectsCtrls>()
                                              .subListtData[index]
                                              .teacher!);
                                  iscamefromCls = false;
                                  // context.read<ClassRoomController>().subName =
                                  // context
                                  //     .read<SubjectsCtrls>()
                                  //     .subListtData[index]
                                  //     .name!;
                                  // context
                                  //     .read<ClassRoomController>()
                                  //     .teacherName =
                                  // context
                                  //     .read<SubjectsCtrls>()
                                  //     .subListtData[index]
                                  //     .teacher!;
                                });
                                log('xxxxxx222222::${context.read<ClassRoomController>().teacherName}');
                                if (context
                                        .read<ClassRoomController>()
                                        .subupdate ==
                                    true) {
                                  context
                                      .read<ClassRoomController>()
                                      .updatedMsg = 'Subject Update';
                                }

                                Get.back();
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SubjectDetails()));
                              }
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
                                                  .watch<SubjectsCtrls>()
                                                  .subListtData[index]
                                                  .name!),
                                              Text(context
                                                  .watch<SubjectsCtrls>()
                                                  .subListtData[index]
                                                  .teacher!),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              width:
                                                  Screens.width(context) * 0.2,
                                              child: Text(
                                                  '${context.watch<SubjectsCtrls>().subListtData[index].credits}'),
                                            ),
                                            const Text('Credits')
                                          ],
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
