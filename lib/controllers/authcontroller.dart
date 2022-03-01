import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:ryz/AppState.dart';
import 'package:ryz/controllers/baseval.dart';
import 'package:http/http.dart' as http;
import 'package:ryz/controllers/authcontroller.dart';

class AuthController {
  String newStr = "";
  Auth auth= new Auth();

  final usernamecontroller = TextEditingController();
  final passwordcontroller = TextEditingController();


  final regnamecontroller = TextEditingController();
  final regemailcontroller = TextEditingController();
  final regmobnocontroller = TextEditingController();
  final regpasswordcontroller = TextEditingController();


  var loginresponse={};

  void strmeth(String val_a) {
    this.newStr = val_a;
  }

  Future<String> loginUser() async {
    var url = Uri.parse(baseurl + 'User/login.php');
    print(url);
    String basicAuth = 'Basic ' + base64Encode(utf8.encode((auth.authname + ':' + auth.authpass)));
    var response = await http.post(url, headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': basicAuth
    }, body: {
      'username': usernamecontroller.text,
      'password': passwordcontroller.text
    });

    var jsonBody = response.body;
    loginresponse = jsonDecode(jsonBody);
    print(jsonBody);
    print(loginresponse["status"]);
    print(loginresponse["message"]);
    RyzAppState().name = loginresponse["name"];
    RyzAppState().email = loginresponse["email"];
    RyzAppState().id = loginresponse["id"];
    RyzAppState().phone = loginresponse["phone"];

    var statusval=loginresponse["status"].toString();


    return statusval;

  }



  Future<String> registerUser() async {
    var url = Uri.parse(baseurl + 'User/signup.php');
    print(url);
    String basicAuth = 'Basic ' + base64Encode(utf8.encode((auth.authname + ':' + auth.authpass)));
    var response = await http.post(url, headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': basicAuth
    }, body: {
      'name': regnamecontroller.text,
      'email': regemailcontroller.text,
      'phone': regmobnocontroller.text,
      'password': regpasswordcontroller.text,
    });

    var jsonBody = response.body;
    print(jsonBody);
    loginresponse = jsonDecode(jsonBody);

    print(loginresponse["status"]);
    print(loginresponse["message"]);
    var statusval=loginresponse["status"].toString();
    return statusval;
  }
}
