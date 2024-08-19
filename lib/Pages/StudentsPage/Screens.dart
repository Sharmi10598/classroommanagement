import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamonapp/Constant/ConstantRoutes.dart';
import 'package:hamonapp/Constant/Screen.dart';
import 'package:hamonapp/Controller/StudentController/StudentControllers.dart';
import 'package:provider/provider.dart';

import 'Widgets/StudentsList.dart';

class StudentsScreen extends StatefulWidget {
  const StudentsScreen({super.key});

  @override
  State<StudentsScreen> createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<stdCtrl>().init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: onBackPressHome,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.keyboard_arrow_left),
            onPressed: () {
              Get.offAllNamed(ConstantRoutes.dashboard);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              top: Screens.padingHeight(context) * 0.03,
              bottom: Screens.padingHeight(context) * 0.02,
              left: Screens.width(context) * 0.02,
              right: Screens.width(context) * 0.02,
            ),
            color: Colors.white,
            child: Column(
              children: [
                Text(
                  'Students',
                  style: theme.textTheme.bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                StudentLists(),
                SizedBox(
                  height: Screens.padingHeight(context) * 0.05,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  DateTime? currentBackPressHome;
  Future<bool> onBackPressHome() {
    DateTime now = DateTime.now();
    if (currentBackPressHome == null ||
        now.difference(currentBackPressHome!) > const Duration(seconds: 2)) {
      currentBackPressHome = now;
      Get.offAllNamed(ConstantRoutes.dashboard);
      return Future.value(false);
    }
    return Future.value(false);
  }
}
