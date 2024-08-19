import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamonapp/Constant/ConstantRoutes.dart';
import 'package:hamonapp/Controller/RegisterCtrl/RegistrationCtrl.dart';
import 'package:hamonapp/Pages/RegistrationPage/Widgets/RegistrationDetails.dart';
import 'package:provider/provider.dart';

import '../../../Constant/Screen.dart';

class RegisterListScreen extends StatefulWidget {
  const RegisterListScreen({super.key});

  @override
  State<RegisterListScreen> createState() => _RegisterListScreenState();
}

class _RegisterListScreenState extends State<RegisterListScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(
            top: Screens.padingHeight(context) * 0.03,
          ),
          height: Screens.padingHeight(context) * 0.7,
          child: context.watch<RegisterController>().isLoading == true &&
                  context.watch<RegisterController>().registtData.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                )
              : context.watch<RegisterController>().registtData.isEmpty
                  ? const Center(child: Text('No Data'))
                  : ListView.builder(
                      itemCount: context
                          .watch<RegisterController>()
                          .registtData
                          .length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 0,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                context.read<RegisterController>().registerid =
                                    context
                                        .read<RegisterController>()
                                        .registtData[index]
                                        .id;
                                // context.read<RegisterController>().studid =
                                //     context
                                //         .read<RegisterController>()
                                //         .registtData[index]
                                //         .student;
                                // context.read<RegisterController>().subsId =
                                //     context
                                //         .read<RegisterController>()
                                //         .registtData[index]
                                //         .subject;

                                context
                                    .read<RegisterController>()
                                    .getStudnadSubDetails(
                                        context
                                            .read<RegisterController>()
                                            .registtData[index]
                                            .student!,
                                        context
                                            .read<RegisterController>()
                                            .registtData[index]
                                            .subject!);
                              });

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RegistDetails()));
                              // .callPostRegApi(context, theme);
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.grey.shade300,
                                    border: Border.all(color: Colors.black26)),
                                padding: EdgeInsets.all(
                                    Screens.padingHeight(context) * 0.015),
                                child: Column(
                                  children: [
                                    Text(
                                        'Registration id: # ${context.watch<RegisterController>().registtData[index].id}'),
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
