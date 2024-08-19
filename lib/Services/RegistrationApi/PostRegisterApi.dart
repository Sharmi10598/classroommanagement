// ignore_for_file: prefer_interpolation_to_compose_strings, unnecessary_new, non_constant_identifier_names, unnecessary_string_interpolations, unused_local_variable, avoid_print

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../../Models/NewRegisterMode.dart';

class PostRegistrationApi {
  static Future<NewRegistersModel> getData(int stuId, int subId) async {
    int resCode = 500;
    try {
      Map<String, String> body = {
        'student': '$stuId',
        'subject': '$subId',
      };
      // log('http://nibrahim.pythonanywhere.com/registration/?api_key=27AFF');
      final response = await http.post(
          Uri.parse(
              "http://nibrahim.pythonanywhere.com/registration/?api_key=27AFF"),
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
          encoding: Encoding.getByName('utf-8'),
          body: body);
      log('response.body::${response.statusCode}');
      // log('post response.body::${response.body}');
      resCode = response.statusCode;
      if (response.statusCode == 200) {
        return NewRegistersModel.fromJson(
            json.decode(response.body), response.statusCode);
      } else if (response.statusCode >= 400 && response.statusCode <= 410) {
        print("Error: error");
        return NewRegistersModel.errorExp(
          json.decode(response.body),
          response.statusCode,
        );
      } else {
        log("APIERRor::" + json.decode(response.body).toString());
        return NewRegistersModel.issue(
            json.decode(response.body), response.statusCode);
      }
    } catch (e) {
      log(" Action Catch:" + e.toString());
      return NewRegistersModel.error(resCode, "$e");
    }
  }
}
