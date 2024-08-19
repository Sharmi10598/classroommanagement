import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../../Constant/ConstantRoutes.dart';
import '../../../Constant/Screen.dart';
import '../../../Controller/ClassRoomCtrl/ClsRoomCtrls.dart';
import '../../SubjectsPage/Widgets/SubList.dart';

class ClsRoomsDet extends StatefulWidget {
  ClsRoomsDet({super.key, required this.title});
  String title;
  @override
  State<ClsRoomsDet> createState() => _ClsRoomsDetState();
}

class _ClsRoomsDetState extends State<ClsRoomsDet> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_left),
          onPressed: () {
            Get.offAllNamed(ConstantRoutes.classroom);
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(
          top: Screens.padingHeight(context) * 0.05,
          bottom: Screens.padingHeight(context) * 0.02,
          left: Screens.width(context) * 0.04,
          right: Screens.width(context) * 0.04,
        ),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              child: Text(
                widget.title,
                style: theme.textTheme.bodyLarge
                    ?.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            SizedBox(
              height: Screens.padingHeight(context) * 0.03,
            ),
            Container(
              width: Screens.width(context),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey.shade300,
              ),
              padding: EdgeInsets.only(
                top: Screens.padingHeight(context) * 0.02,
                bottom: Screens.padingHeight(context) * 0.02,
                left: Screens.width(context) * 0.03,
                right: Screens.width(context) * 0.03,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  context.read<ClassRoomController>().subName.isNotEmpty &&
                          context
                              .read<ClassRoomController>()
                              .teacherName
                              .isNotEmpty
                      ? SizedBox(
                          width: Screens.width(context) * 0.5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(context.read<ClassRoomController>().subName),
                              Text(context
                                  .read<ClassRoomController>()
                                  .teacherName)
                            ],
                          ),
                        )
                      : Container(
                          child: const Text('Add Subject'),
                        ),
                  context.read<ClassRoomController>().subName.isNotEmpty &&
                          context
                              .read<ClassRoomController>()
                              .teacherName
                              .isNotEmpty
                      ? Container(
                          height: Screens.padingHeight(context) * 0.045,
                          width: Screens.width(context) * 0.3,
                          margin: const EdgeInsets.only(right: 10, left: 10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                foregroundColor: Colors.green,
                                backgroundColor: Colors.green.shade50),
                            onPressed: () {
                              setState(() {
                                SubjectsListsState.iscamefromCls = true;
                                context.read<ClassRoomController>().subupdate =
                                    true;
                                context.read<ClassRoomController>().updatedMsg =
                                    '';
                                Get.toNamed(ConstantRoutes.subject);
                              });
                            },
                            child: const Center(
                              child: Text('Change'),
                            ),
                          ),
                        )
                      : Container(
                          height: Screens.padingHeight(context) * 0.045,
                          width: Screens.width(context) * 0.3,
                          margin: const EdgeInsets.only(right: 10, left: 10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                foregroundColor: Colors.green,
                                backgroundColor: Colors.green.shade50),
                            onPressed: () {
                              context.read<ClassRoomController>().subName = '';
                              context.read<ClassRoomController>().teacherName =
                                  '';
                              setState(() {
                                SubjectsListsState.iscamefromCls = true;
                                Get.toNamed(ConstantRoutes.subject);
                              });
                            },
                            child: const Center(
                              child: Text('Add'),
                            ),
                          ),
                        ),
                ],
              ),
            ),
            SizedBox(
              height: Screens.padingHeight(context) * 0.1,
            ),
            context.read<ClassRoomController>().layoutt == 'conference'
                ? SizedBox(
                    height: Screens.padingHeight(context) * 0.5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: Screens.padingHeight(context) * 0.45,
                          width: Screens.width(context) * 0.07,
                          child: ListView.builder(
                              itemCount: 8,
                              itemBuilder: (context, index) {
                                return Container(
                                  height: Screens.padingHeight(context) * 0.05,
                                  width: Screens.width(context) * 0.1,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/student.png'))),
                                );
                              }),
                        ),
                        SizedBox(
                          width: Screens.width(context) * 0.02,
                        ),
                        Container(
                          height: Screens.padingHeight(context) * 0.45,
                          width: Screens.width(context) * 0.3,
                          color: Colors.grey.shade300,
                        ),
                        SizedBox(
                          width: Screens.width(context) * 0.02,
                        ),
                        SizedBox(
                          height: Screens.padingHeight(context) * 0.45,
                          width: Screens.width(context) * 0.07,
                          child: ListView.builder(
                              itemCount: 8,
                              itemBuilder: (context, index) {
                                return Container(
                                  height: Screens.padingHeight(context) * 0.05,
                                  width: Screens.width(context) * 0.1,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/student.png'))),
                                );
                              }),
                        ),
                      ],
                    ),
                  )
                : Container(
                    padding: EdgeInsets.only(
                      left: Screens.width(context) * 0.05,
                      right: Screens.width(context) * 0.05,
                    ),
                    height: Screens.padingHeight(context) * 0.5,
                    width: Screens.width(context) * 0.8,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: 30,
                              mainAxisSpacing: 30,
                              crossAxisCount: 4),
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.all(8),
                          height: Screens.padingHeight(context) * 0.01,
                          width: Screens.width(context) * 0.01,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                          ),
                          child: const Image(
                              image: AssetImage('assets/student.png')),
                        );
                      },
                    ),
                  ),
            context.watch<ClassRoomController>().updatedMsg.isNotEmpty
                ? Text(
                    context.read<ClassRoomController>().updatedMsg,
                    style: const TextStyle(color: Colors.green, fontSize: 18),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
