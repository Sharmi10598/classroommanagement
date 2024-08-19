import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamonapp/Constant/Screen.dart';
import 'package:provider/provider.dart';

import '../../../Constant/ConstantRoutes.dart';
import '../../../Controller/SubjectController/SubjectCtrls.dart';

class SubjectDetails extends StatefulWidget {
  const SubjectDetails({super.key});

  @override
  State<SubjectDetails> createState() => _SubjectDetailsState();
}

class _SubjectDetailsState extends State<SubjectDetails> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_left),
          onPressed: () {
            Get.offAllNamed(ConstantRoutes.subject);
          },
        ),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: Screens.padingHeight(context) * 0.05,
            ),
            Container(
                alignment: Alignment.center,
                child: Text(
                  'Subject Details',
                  style: theme.textTheme.bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                )),
            SizedBox(
              height: Screens.padingHeight(context) * 0.1,
            ),
            Column(
              children: [
                Text(
                  context.watch<SubjectsCtrls>().fetchSubListData.name!,
                  style: theme.textTheme.bodyLarge?.copyWith(fontSize: 18),
                ),
                SizedBox(
                  height: Screens.padingHeight(context) * 0.005,
                ),
                Text(
                  "${context.watch<SubjectsCtrls>().fetchSubListData.teacher}",
                  style: theme.textTheme.bodyLarge?.copyWith(fontSize: 18),
                ),
                SizedBox(
                  height: Screens.padingHeight(context) * 0.005,
                ),
                Text(
                    "Credit : ${context.watch<SubjectsCtrls>().fetchSubListData.credits}"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
