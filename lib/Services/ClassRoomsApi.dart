// ignore_for_file: prefer_interpolation_to_compose_strings, unnecessary_new, non_constant_identifier_names, unnecessary_string_interpolations, unused_local_variable, avoid_print

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import '../Models/ClassRoomsModel.dart';

class GetClsRoomsListApi {
  static Future<GetClassRoomModel> getData() async {
    int resCode = 500;

    try {
      final response = await http.get(
        Uri.parse(
            "http://nibrahim.pythonanywhere.com/classrooms/?api_key=27AFF"),
      );
      log('response.body::${response.statusCode}');
// log('response.body::${response.body}');
      resCode = response.statusCode;
      if (response.statusCode == 200) {
        return GetClassRoomModel.fromJson(
            json.decode(response.body), response.statusCode);
      } else if (response.statusCode >= 400 && response.statusCode <= 410) {
        print("Error: error");
        return GetClassRoomModel.issue(response.statusCode,
            json.decode(response.body), response.statusCode);
      } else {
        log("APIERRor::" + json.decode(response.body).toString());
        return GetClassRoomModel.issue(response.statusCode,
            json.decode(response.body), response.statusCode);
      }
    } catch (e) {
      log(" Action Catch:" + e.toString());
      return GetClassRoomModel.error(resCode, "$e");
    }
  }
}
