import 'package:flutter/material.dart';

class DashboardCtrls extends ChangeNotifier {
  bool? changwicon = false;
  changeIcons() {
    if (changwicon == false) {
      changwicon = true;
    } else {
      changwicon = false;
    }
    notifyListeners();
  }
}
