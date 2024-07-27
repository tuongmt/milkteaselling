// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_coffee_app/models/user_model.dart';
import 'package:flutter_coffee_app/screen/login/login.dart';

import 'package:shared_preferences/shared_preferences.dart';

Future<bool> saveUser(UserModel userModel) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String strUser = jsonEncode(userModel.copyWith().toJson());
    prefs.setString('userInfo', strUser);

    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<bool> logOut(BuildContext context) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userInfo', '');
    print("Logout thành công");
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
        (route) => false);
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

//
Future<UserModel> getUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String strUser = prefs.getString('userInfo')!;
  print("Luu thanh cong1: ${strUser}");

  return UserModel.fromJson(jsonDecode(strUser));
}
