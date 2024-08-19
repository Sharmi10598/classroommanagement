import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamonapp/Controller/RegisterCtrl/RegistrationCtrl.dart';
import 'package:provider/provider.dart';

import '../../Constant/ConstantRoutes.dart';
import '../../Constant/Screen.dart';
import 'Widgets/NewRegisterPage.dart';
import 'Widgets/RegisterList.dart';

class RegisterScreens extends StatefulWidget {
  const RegisterScreens({super.key});

  @override
  State<RegisterScreens> createState() => _RegisterScreensState();
}

class _RegisterScreensState extends State<RegisterScreens> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<RegisterController>().init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return WillPopScope(
      onWillPop: () => onBackPressHome(context),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.keyboard_arrow_left),
            onPressed: () {
              Get.offAllNamed(ConstantRoutes.dashboard);
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Container(
          height: Screens.padingHeight(context) * 0.06,
          width: Screens.width(context) * 0.5,
          child: FloatingActionButton(
            focusElevation: 0,
            elevation: 0,
            onPressed: () {
              setState(() {
                context.read<RegisterController>().mycontroller[0].text = '';
                context.read<RegisterController>().mycontroller[1].text = '';
                context.read<RegisterController>().delMessage = '';

                Navigator.push(
                    context,
                    (MaterialPageRoute(
                        builder: (context) => const NewRegistration())));
              });
            },
            child: const Text(
              'New Registration',
              style: TextStyle(color: Colors.blue),
            ),
          ),

          //  FloatingActionButton(

          //   onPressed: () {},
          //   child: Text('New Registration',style: TextStyle(color: Colors.blue),),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              top: Screens.padingHeight(context) * 0.05,
              bottom: Screens.padingHeight(context) * 0.02,
              left: Screens.width(context) * 0.02,
              right: Screens.width(context) * 0.02,
            ),
            child: Column(
              children: [
                Text(
                  'Registration',
                  style: theme.textTheme.bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const RegisterListScreen(),
                SizedBox(
                  height: Screens.padingHeight(context) * 0.02,
                ),
                Text(
                  context.watch<RegisterController>().getdelMessage.isNotEmpty
                      ? context.watch<RegisterController>().getdelMessage
                      : '',
                  style:
                      theme.textTheme.bodyLarge?.copyWith(color: Colors.green),
                ),
                SizedBox(
                  height: Screens.padingHeight(context) * 0.03,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  DateTime? currentBackPressHome;
  Future<bool> onBackPressHome(BuildContext context) {
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
