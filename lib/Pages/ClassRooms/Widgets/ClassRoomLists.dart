// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Constant/Screen.dart';
import '../../../Controller/ClassRoomCtrl/ClsRoomCtrls.dart';
import 'ClsRoomDetails.dart';

class ClassRoomsList extends StatefulWidget {
  const ClassRoomsList({super.key});

  @override
  State<ClassRoomsList> createState() => _ClassRoomsListState();
}

class _ClassRoomsListState extends State<ClassRoomsList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(
            top: Screens.padingHeight(context) * 0.03,
          ),
          height: Screens.padingHeight(context),
          child: context.watch<ClassRoomController>().clsListtData.isEmpty &&
                  context.watch<ClassRoomController>().isLoading == true
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : context.watch<ClassRoomController>().clsListtData.isEmpty
                  ? Center(child: Text('No Data'))
                  : ListView.builder(
                      itemCount: context
                          .watch<ClassRoomController>()
                          .clsListtData
                          .length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 0,
                          child: GestureDetector(
                            onTap: () {
                              context
                                  .read<ClassRoomController>()
                                  .fetchClassDet(index);
                              context.read<ClassRoomController>().layoutt =
                                  context
                                      .read<ClassRoomController>()
                                      .clsListtData[index]
                                      .layout!;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ClsRoomsDet(
                                          title: context
                                              .read<ClassRoomController>()
                                              .clsListtData[index]
                                              .name!)));
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
                                        Container(
                                          width: Screens.width(context) * 0.65,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(context
                                                  .watch<ClassRoomController>()
                                                  .clsListtData[index]
                                                  .name!),
                                              Text(context
                                                  .watch<ClassRoomController>()
                                                  .clsListtData[index]
                                                  .layout!),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          width: Screens.width(context) * 0.2,
                                          child: Column(
                                            children: [
                                              Text(
                                                  '${context.watch<ClassRoomController>().clsListtData[index].size}'),
                                              Text('Seats')
                                            ],
                                          ),
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
