import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamonapp/Controller/ClassRoomCtrl/ClsRoomCtrls.dart';
import 'package:provider/provider.dart';

import '../../Constant/ConstantRoutes.dart';
import '../../Constant/Screen.dart';
import 'Widgets/ClassRoomLists.dart';

class ClassRoomScreen extends StatefulWidget {
  const ClassRoomScreen({super.key});

  @override
  State<ClassRoomScreen> createState() => _ClassRoomScreenState();
}

class _ClassRoomScreenState extends State<ClassRoomScreen> {
  @override
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ClassRoomController>().init(context);
    });
  }

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
                top: Screens.padingHeight(context) * 0.02,
                bottom: Screens.padingHeight(context) * 0.02,
                left: Screens.width(context) * 0.02,
                right: Screens.width(context) * 0.02,
              ),
              color: Colors.white,
              child: Column(
                children: [
                  Text(
                    'Class Rooms',
                    style: theme.textTheme.bodyLarge
                        ?.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const ClassRoomsList(),
                  SizedBox(
                    height: Screens.padingHeight(context) * 0.05,
                  )
                ],
              ),
            ),
          )),
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
