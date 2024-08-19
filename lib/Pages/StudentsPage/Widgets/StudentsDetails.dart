// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamonapp/Constant/Screen.dart';
import 'package:hamonapp/Controller/StudentController/StudentControllers.dart';
import 'package:provider/provider.dart';

import '../../../Constant/ConstantRoutes.dart';

class StdDetails extends StatefulWidget {
  const StdDetails({super.key});

  @override
  State<StdDetails> createState() => _StdDetailsState();
}

class _StdDetailsState extends State<StdDetails> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left),
          onPressed: () {
            Get.offAllNamed(ConstantRoutes.students);
          },
        ),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: Screens.padingHeight(context) * 0.005,
            ),
            Container(
                alignment: Alignment.center,
                child: Text(
                  'Student Details',
                  style: theme.textTheme.bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                )),
            SizedBox(
              height: Screens.padingHeight(context) * 0.1,
            ),
            Container(
                height: Screens.padingHeight(context) * 0.125,
                width: Screens.width(context) * 0.5,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(
                    color: theme.primaryColor,
                  ),
                ),
                child: GestureDetector(
                    child: Container(
                        width: Screens.width(context) * 0.1,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage("assets/avatar.png"),
                                fit: BoxFit.cover))))),
            SizedBox(
              height: Screens.padingHeight(context) * 0.02,
            ),
            Column(
              children: [
                Text(
                  context.watch<stdCtrl>().fetchStdListData != null
                      ? context.watch<stdCtrl>().fetchStdListData!.name!
                      : '',
                  style: theme.textTheme.bodyLarge?.copyWith(fontSize: 18),
                ),
                SizedBox(
                  height: Screens.padingHeight(context) * 0.005,
                ),
                Text(
                  "Age : ${context.watch<stdCtrl>().fetchStdListData != null ? context.watch<stdCtrl>().fetchStdListData!.age : ''}",
                  style: theme.textTheme.bodyLarge?.copyWith(fontSize: 18),
                ),
                SizedBox(
                  height: Screens.padingHeight(context) * 0.005,
                ),
                Text(context.watch<stdCtrl>().fetchStdListData != null
                    ? context
                        .watch<stdCtrl>()
                        .fetchStdListData!
                        .email
                        .toString()
                    : ''),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
