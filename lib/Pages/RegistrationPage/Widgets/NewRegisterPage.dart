import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../Constant/ConstantRoutes.dart';
import '../../../Constant/Screen.dart';
import '../../../Controller/RegisterCtrl/RegistrationCtrl.dart';
import '../../StudentsPage/Widgets/StudentsList.dart';
import '../../SubjectsPage/Widgets/SubList.dart';

class NewRegistration extends StatefulWidget {
  const NewRegistration({super.key});

  @override
  State<NewRegistration> createState() => NewRegistrationState();
}

class NewRegistrationState extends State<NewRegistration> {
  static String stdName = '';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left),
          onPressed: () {
            Get.offAllNamed(ConstantRoutes.dashboard);
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: Screens.padingHeight(context) * 0.01),
        child: Column(
          children: [
            Text(
              'New Registration',
              style: theme.textTheme.bodyLarge
                  ?.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
              height: Screens.padingHeight(context) * 0.04,
            ),
            Form(
              key: context.watch<RegisterController>().formkey[0],
              child: Container(
                padding: EdgeInsets.only(
                  top: Screens.padingHeight(context) * 0.01,
                  left: Screens.width(context) * 0.05,
                  right: Screens.width(context) * 0.05,
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                alignment: Alignment.center,
                child: TextFormField(
                  onChanged: (value) {},
                  controller:
                      context.watch<RegisterController>().mycontroller[0],
                  readOnly: true,
                  onEditingComplete: () {},
                  onTap: () {
                    StudentListsState.iscamefromReg = true;
                    Get.toNamed(ConstantRoutes.students);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Select a Student';
                    }
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.grey[300],
                    suffixIcon: Icon(Icons.keyboard_arrow_right),
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: Screens.width(context) * 0.03,
                        vertical: Screens.fullHeight(context) * 0.01),
                    hintText: 'Select a Student',
                    labelStyle:
                        theme.textTheme.bodyLarge?.copyWith(color: Colors.grey),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Screens.padingHeight(context) * 0.02,
            ),
            Container(
              padding: EdgeInsets.only(
                top: Screens.padingHeight(context) * 0.01,
                left: Screens.width(context) * 0.05,
                right: Screens.width(context) * 0.05,
              ),
              alignment: Alignment.center,
              child: TextFormField(
                readOnly: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Select a Subject';
                  }
                },
                controller: context.watch<RegisterController>().mycontroller[1],
                onEditingComplete: () {},
                onTap: () {
                  SubjectsListsState.iscamefromReg = true;
                  Get.toNamed(ConstantRoutes.subject);
                },
                decoration: InputDecoration(
                    fillColor: Colors.grey[300],
                    filled: true,
                    suffixIcon: Icon(Icons.keyboard_arrow_right),
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: Screens.width(context) * 0.03,
                        vertical: Screens.fullHeight(context) * 0.01),
                    hintText: 'Select a Subject',
                    labelStyle:
                        theme.textTheme.bodyLarge?.copyWith(color: Colors.grey),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8))),
              ),
            ),
            SizedBox(
              height: Screens.padingHeight(context) * 0.05,
            ),
            Container(
              height: Screens.padingHeight(context) * 0.05,
              width: Screens.width(context) * 0.4,
              margin: const EdgeInsets.only(right: 10, left: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green),
                onPressed: () {
                  if (context
                      .read<RegisterController>()
                      .formkey[0]
                      .currentState!
                      .validate()) {
                    context
                        .read<RegisterController>()
                        .callPostNewRegApi(context, theme);
                  }
                },
                child: const Center(
                  child: Text('Register'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
