import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../Constant/ConstantRoutes.dart';
import '../../Constant/Screen.dart';
import '../../Controller/SubjectController/SubjectCtrls.dart';
import 'Widgets/SubList.dart';

class SubjectsScreen extends StatefulWidget {
  const SubjectsScreen({super.key});

  @override
  State<SubjectsScreen> createState() => _SubjectsScreenState();
}

class _SubjectsScreenState extends State<SubjectsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<SubjectsCtrls>().init(context);
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
            child: Column(
              children: [
                Text(
                  'Subjects',
                  style: theme.textTheme.bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SubjectsLists(),
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
