// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter_coffee_app/config/routes.dart';
import 'package:flutter_coffee_app/data/app_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

const net_img_url = 'http://10.21.39.155:8080/uploads/images/';
const img_url = "/images";
const img_category_url = "$img_url/category/";
const img_deal_url = "$img_url/deal/";
const img_milktea_url = "$img_url/milktea/";
const img_fruittea_url = "$img_url/fruittea/";
const img_oolongtea_url = "$img_url/oolongtea/";
const img_snack_url = "$img_url/snack/";
const img_topping_url = "$img_url/topping/";
const img_offer_url = "$img_url/offer/";

void showMessage(String message) {
  Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0);
}

void showConfirmationDialog(BuildContext context, String txtBtn,
    void Function()? onPressed, String message) {
  AppProvider appProvider = Provider.of<AppProvider>(context);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Xác nhận'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('Hủy'),
            onPressed: () {
              Navigator.of(context).pop(); 
            },
          ),
          TextButton(
            child: Text(txtBtn),
            onPressed: onPressed,
          ),
        ],
      );
    },
  );
}

showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Builder(
      builder: (context) {
        return SizedBox(
          width: 100,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(
                color: Colors.orange,
                backgroundColor: Colors.white,
              ),
              const SizedBox(
                height: 18.0,
              ),
              Container(
                margin: const EdgeInsets.only(left: 7),
                child: const Text("Loading..."),
              )
            ],
          ),
        );
      },
    ),
  );
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      });
}

String getMessageFromErrorCode(String errCode) {
  switch (errCode) {
    case "ERROR_EMAIL_ALREADY_IN_USE":
      return "Email already used!";
    case "ERROR_WRONG_PASSWORD":
      return "Password is wrong!";
    case "ERROR_USER_NOT_FOUND":
      return "No user found with this email!";
    case "ERROR_USER_DISABLED":
      return "User disabled!";
    case "ERROR_INVALID_EMAIL":
      return "Email address is invalid!";
    default:
      return "Login failed. Please try again.";
  }
}

bool loginValidation(String email, String password) {
  if (email.isEmpty && password.isEmpty) {
    showMessage("Both fields are empty");
    return false;
  } else if (email.isEmpty) {
    showMessage("Email is empty");
    return false;
  } else if (password.isEmpty) {
    showMessage("Password is empty");
    return false;
  } else {
    return true;
  }
}

bool signUpValidation(
    String email, String password, String name, String phone) {
  if (email.isEmpty && password.isEmpty && name.isEmpty && phone.isEmpty) {
    showMessage("All fields are empty");
    return false;
  } else if (name.isEmpty) {
    showMessage("Name is empty");
    return false;
  } else if (email.isEmpty) {
    showMessage("Email is empty");
    return false;
  } else if (phone.isEmpty) {
    showMessage("Phone is empty");
    return false;
  } else if (password.isEmpty) {
    showMessage("Password is empty");
    return false;
  } else {
    return true;
  }
}
