import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamonapp/Constant/Screen.dart';
import 'package:hamonapp/Controller/DashboardController/DashboardControllers.dart';
import 'package:provider/provider.dart';
import '../../Constant/ConstantRoutes.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return WillPopScope(
      onWillPop: onBackPressExit,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: Screens.padingHeight(context) * 0.15,
          backgroundColor: Colors.white,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hello,',
                  style: theme.textTheme.headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold)),
              Text('Good Morning',
                  style: theme.textTheme.bodyMedium?.copyWith(fontSize: 17)),
            ],
          ),
          actions: [
            context.watch<DashboardCtrls>().changwicon == false
                ? SizedBox(
                     height: Screens.padingHeight(context) * 0.03,
                      width: Screens.width(context) * 0.2,
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          context.read<DashboardCtrls>().changeIcons();
                        });
                      },
                      icon: Icon(Icons.menu)),
                )
                : InkWell(
                    onTap: () {
                      setState(() {
                        context.read<DashboardCtrls>().changeIcons();
                      });
                    },
                    child: SizedBox(
                      height: Screens.padingHeight(context) * 0.03,
                      width: Screens.width(context) * 0.2,
                      child: Image(image: AssetImage('assets/four-circle.png')),
                    ))
          ],
        ),
        body: SingleChildScrollView(
          child: context.watch<DashboardCtrls>().changwicon == false
              ? Container(
                  height: Screens.padingHeight(context),
                  padding: EdgeInsets.only(
                      top: Screens.padingHeight(context) * 0.06,
                      bottom: Screens.padingHeight(context) * 0.03,
                      left: Screens.width(context) * 0.05,
                      right: Screens.width(context) * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(ConstantRoutes.students);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.green.shade100,
                              ),
                              alignment: Alignment.center,
                              width: Screens.width(context) * 0.43,
                              height: Screens.padingHeight(context) * 0.25,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.school_outlined,
                                    color: Colors.green,
                                    size: 40,
                                  ),
                                  Container(child: const Text('Student')),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(ConstantRoutes.subject);
                              // ConstantRoutes.subject
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.blue.shade100,
                              ),
                              alignment: Alignment.center,
                              width: Screens.width(context) * 0.43,
                              height: Screens.padingHeight(context) * 0.25,
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.menu_book_outlined,
                                    size: 40,
                                    color: Colors.blue,
                                  ),
                                  Text('Subjects'),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: Screens.padingHeight(context) * 0.03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(ConstantRoutes.classroom);
                            },
                            child: Container(
                              width: Screens.width(context) * 0.43,
                              height: Screens.padingHeight(context) * 0.25,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.pink.shade100,
                              ),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.meeting_room_outlined,
                                    color: Colors.pink,
                                    size: 40,
                                  ),
                                  Text('Class Rooms'),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(ConstantRoutes.register);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.orange.shade100,
                              ),
                              alignment: Alignment.center,
                              width: Screens.width(context) * 0.43,
                              height: Screens.padingHeight(context) * 0.25,
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.edit,
                                    color: Colors.orange,
                                    size: 40,
                                  ),
                                  Text('Registration'),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              : Container(
                  height: Screens.padingHeight(context),
                  padding: EdgeInsets.only(
                      top: Screens.padingHeight(context) * 0.08,
                      bottom: Screens.padingHeight(context) * 0.03,
                      left: Screens.width(context) * 0.05,
                      right: Screens.width(context) * 0.05),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(ConstantRoutes.students);
                        },
                        child: Container(
                          width: Screens.width(context),
                          height: Screens.padingHeight(context) * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.green.shade100,
                          ),
                          alignment: Alignment.center,
                          child: const Text('Students'),
                        ),
                      ),
                      SizedBox(height: Screens.padingHeight(context) * 0.03),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(ConstantRoutes.subject);
                        },
                        child: Container(
                          width: Screens.width(context),
                          height: Screens.padingHeight(context) * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.blue.shade100,
                          ),
                          alignment: Alignment.center,
                          child: const Text('Subjects'),
                        ),
                      ),
                      SizedBox(height: Screens.padingHeight(context) * 0.03),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(ConstantRoutes.classroom);
                        },
                        child: Container(
                          width: Screens.width(context),
                          height: Screens.padingHeight(context) * 0.05,
                          child: const Text('Class Rooms'),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.pink.shade100,
                          ),
                          alignment: Alignment.center,
                        ),
                      ),
                      SizedBox(height: Screens.padingHeight(context) * 0.03),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(ConstantRoutes.register);
                        },
                        child: Container(
                          width: Screens.width(context),
                          height: Screens.padingHeight(context) * 0.05,
                          child: Text('Registration'),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.orange.shade100,
                          ),
                          alignment: Alignment.center,
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Future<bool> onBackPressExit() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            insetPadding: const EdgeInsets.all(10),
            contentPadding: const EdgeInsets.all(0),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            // title: Text("Are you sure?"),
            // content: Text("Do you want to exit?"),
            content: SizedBox(
              width: Screens.width(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: Screens.width(context),
                    height: Screens.bodyheight(context) * 0.06,
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,

                          textStyle: const TextStyle(
                              // fontSize: 12,
                              ),
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                          )), //Radius.circular(6)
                        ),
                        child: const Text("Alert",
                            style:
                                TextStyle(fontSize: 15, color: Colors.white))),
                  ),
                  SizedBox(
                    height: Screens.padingHeight(context) * 0.01,
                  ),
                  Container(
                      padding: const EdgeInsets.only(left: 40),
                      width: Screens.width(context) * 0.85,
                      child: const Divider(
                        color: Colors.grey,
                      )),
                  Container(
                      alignment: Alignment.center,
                      // width: Screens.width(context)*0.5,
                      // padding: EdgeInsets.only(left:20),
                      child: const Text(
                        "Are you sure",
                        style: TextStyle(fontSize: 15),
                      )),
                  SizedBox(
                    height: Screens.padingHeight(context) * 0.01,
                  ),
                  Container(
                      alignment: Alignment.center,
                      // padding: EdgeInsets.only(left:20),
                      child: const Text("Do you want to exit?",
                          style: TextStyle(fontSize: 15))),
                  Container(
                      padding: const EdgeInsets.only(left: 40),
                      width: Screens.width(context) * 0.85,
                      child: const Divider(color: Colors.grey)),
                  SizedBox(
                    height: Screens.bodyheight(context) * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: Screens.width(context) * 0.47,
                        height: Screens.bodyheight(context) * 0.06,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,

                              // primary: theme.primaryColor,
                              textStyle: const TextStyle(color: Colors.white),
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(0),
                              )),
                            ),
                            onPressed: () {
                              exit(0);
                            },
                            child: const Text(
                              "Yes",
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                      SizedBox(
                        width: Screens.width(context) * 0.47,
                        height: Screens.bodyheight(context) * 0.06,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,

                              // primary: theme.primaryColor,
                              textStyle: const TextStyle(color: Colors.white),
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(10),
                              )),
                            ),
                            onPressed: () {
                              setState(() {
                                Navigator.of(context).pop(false);
                              });
                              // context.read<EnquiryUserContoller>().checkDialogCon();
                            },
                            child: const Text(
                              "No",
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )) ??
        false;
  }
}
// {"classrooms":[{"id":1,"layout":"classroom","name":"LightSeaGreen","size":21},
// {"id":2,"layout":"classroom","name":"LightCyan","size":21},{"id":3,"layout":"conference","name":"BlueViolet","size":16},{"id":4,"layout":"conference","name":"PaleGreen","size":21},{"id":5,"layout":"classroom","name":"DarkSlateBlue","size":22},{"id":6,"layout":"classroom","name":"MediumSeaGreen","size":18}]}



