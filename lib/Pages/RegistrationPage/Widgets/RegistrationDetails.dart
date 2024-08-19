import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamonapp/Controller/RegisterCtrl/RegistrationCtrl.dart';
import 'package:provider/provider.dart';
import '../../../Constant/ConstantRoutes.dart';
import '../../../Constant/Screen.dart';

class RegistDetails extends StatefulWidget {
  const RegistDetails({super.key});
  @override
  State<RegistDetails> createState() => _RegistDetailsState();
}

class _RegistDetailsState extends State<RegistDetails> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.keyboard_arrow_left),
            onPressed: () {
              Get.offAllNamed(ConstantRoutes.register);
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: SizedBox(
          height: Screens.padingHeight(context) * 0.06,
          width: Screens.width(context) * 0.5,
          child: FloatingActionButton(
            backgroundColor: Colors.red,
            focusElevation: 0,
            elevation: 0,
            onPressed: () {
              setState(() {
                log('Lllllllll::${context.read<RegisterController>().registerid}');
                context
                    .read<RegisterController>()
                    .deleteAlertMessage(context, theme);
              });
            },
            child: const Text(
              'Delete Registration',
              style: TextStyle(color: Colors.white),
            ),
          ),

          //  FloatingActionButton(

          //   onPressed: () {},
          //   child: Text('New Registration',style: TextStyle(color: Colors.blue),),
        ),
        body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.only(
                  top: Screens.padingHeight(context) * 0.02,
                  bottom: Screens.padingHeight(context) * 0.02,
                  left: Screens.width(context) * 0.03,
                  right: Screens.width(context) * 0.03,
                ),
                color: Colors.white,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          'Registration',
                          style: theme.textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: Screens.padingHeight(context) * 0.04,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey.shade300,
                        ),
                        padding: EdgeInsets.only(
                          top: Screens.padingHeight(context) * 0.01,
                          bottom: Screens.padingHeight(context) * 0.01,
                          left: Screens.width(context) * 0.03,
                          right: Screens.width(context) * 0.03,
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Student Details',
                                style: theme.textTheme.bodyLarge,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(context
                                              .watch<RegisterController>()
                                              .stddListData
                                              .name !=
                                          null
                                      ? context
                                          .watch<RegisterController>()
                                          .stddListData
                                          .name!
                                      : ''),
                                  Text(
                                      "Age : ${context.watch<RegisterController>().stddListData.age ?? ''}"),
                                ],
                              ),
                              Text(context
                                      .watch<RegisterController>()
                                      .stddListData
                                      .email ??
                                  ''),
                            ]),
                      ),
                      SizedBox(
                        height: Screens.padingHeight(context) * 0.02,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey.shade300,
                        ),
                        padding: EdgeInsets.only(
                          top: Screens.padingHeight(context) * 0.01,
                          bottom: Screens.padingHeight(context) * 0.01,
                          left: Screens.width(context) * 0.03,
                          right: Screens.width(context) * 0.03,
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Subject Details',
                                  style: theme.textTheme.bodyLarge),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(context
                                          .watch<RegisterController>()
                                          .subListData
                                          .name ??
                                      ""),
                                  Text(
                                      "Credits : ${context.watch<RegisterController>().subListData.credits ?? ''}"),
                                ],
                              ),
                              Text(context
                                      .watch<RegisterController>()
                                      .subListData
                                      .teacher ??
                                  ""),
                            ]),
                      )
                    ]))));
  }
}
