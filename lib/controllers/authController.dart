import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:ryz/AppState.dart';
import 'package:ryz/controllers/baseValues.dart';

class AuthController {
  String newStr = "";

  Auth auth = new Auth();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final registerNameController = TextEditingController();
  final registerMailController = TextEditingController();
  final registerMobileNoController = TextEditingController();
  final registerPasswordController = TextEditingController();

  var loginResponse = {};

  void stringMethod({required String valA}) {
    this.newStr = valA;
  }

  Future<String> loginUser() async {
    var url = Uri.parse(baseurl + 'User/login.php');
    print(url);
    String basicAuth = 'Basic ' + base64Encode(utf8.encode((auth.authName + ':' + auth.authPass)));
    var response = await http.post(url,
        headers: <String, String>{'Content-Type': 'application/x-www-form-urlencoded', 'Authorization': basicAuth},
        body: {'username': usernameController.text, 'password': passwordController.text});

    var jsonBody = response.body;
    loginResponse = jsonDecode(jsonBody);
    print(jsonBody);
    print(loginResponse["status"]);
    print(loginResponse["message"]);
    RyzAppState().name = loginResponse["name"];
    RyzAppState().email = loginResponse["email"];
    RyzAppState().id = loginResponse["id"];
    RyzAppState().phone = loginResponse["phone"];

    var status = loginResponse["status"].toString();

    return status;
  }

  Future<String> registerUser() async {
    var url = Uri.parse(baseurl + 'User/signup.php');
    print(url);
    String basicAuth = 'Basic ' + base64Encode(utf8.encode((auth.authName + ':' + auth.authPass)));
    var response = await http.post(url, headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': basicAuth
    }, body: {
      'name': registerNameController.text,
      'email': registerMailController.text,
      'phone': registerMobileNoController.text,
      'password': registerPasswordController.text,
    });

    var jsonBody = response.body;
    print(jsonBody);
    loginResponse = jsonDecode(jsonBody);

    print(loginResponse["status"]);
    print(loginResponse["message"]);
    var status = loginResponse["status"].toString();
    return status;
  }
}
