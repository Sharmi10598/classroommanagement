// ignore_for_file: prefer_interpolation_to_compose_strings, unnecessary_new, non_constant_identifier_names, unnecessary_string_interpolations, unused_local_variable, avoid_print

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import '../../Models/RegisterModel.dart';

class GetRegistrationApi {
  static Future<GetRegisterModel> getData() async {
    int resCode = 500;

    try {
      final response = await http.get(
        Uri.parse(
            "http://nibrahim.pythonanywhere.com/registration/?api_key=27AFF"),
      );
      log('response.body::${response.statusCode}');
// log('response.body::${response.body}');
      resCode = response.statusCode;
      if (response.statusCode == 200) {
        return GetRegisterModel.fromJson(
            json.decode(response.body), response.statusCode);
      } else if (response.statusCode >= 400 && response.statusCode <= 410) {
        print("Error: error");
        return GetRegisterModel.errorExp(
            json.decode(response.body), response.statusCode);
      } else {
        log("APIERRor::" + json.decode(response.body).toString());
        return GetRegisterModel.issue(
            json.decode(response.body), response.statusCode);
      }
    } catch (e) {
      log(" Action Catch:" + e.toString());
      return GetRegisterModel.error(resCode, "$e");
    }
  }
}
