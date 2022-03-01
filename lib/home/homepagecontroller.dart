import 'dart:convert';

import 'package:ryz/controllers/baseval.dart';
import 'package:http/http.dart' as http;

class HomeController {
  String newStr = "";
  Auth auth= new Auth();

  var categoryResults={};

  void strMethod(String valA) {
    this.newStr = valA;
  }

  Future fetchCategories() async {
    var url = Uri.parse(baseurl + 'Category/category.php');
    print(url);
    String basicAuth = 'Basic ' + base64Encode(utf8.encode((auth.authname + ':' + auth.authpass)));

    var response = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': basicAuth
    },);

    var jsonBody = response.body;
    print(jsonBody);
    categoryResults = jsonDecode(jsonBody);
    
    print(categoryResults["data"]);
    print(categoryResults["data"][0]["category_name"]);
  }


  //
  // Future<String> registerUser() async {
  //   var url = Uri.parse(baseurl + 'User/signup.php');
  //   print(url);
  //   String basicAuth = 'Basic ' + base64Encode(utf8.encode((auth.authname + ':' + auth.authpass)));
  //   var response = await http.post(url, headers: <String, String>{
  //     'Content-Type': 'application/x-www-form-urlencoded',
  //     'Authorization': basicAuth
  //   }, body: {
  //     'name': regnamecontroller.text,
  //     'email': regemailcontroller.text,
  //     'phone': regmobnocontroller.text,
  //     'password': regpasswordcontroller.text,
  //   });
  //
  //   var jsonBody = response.body;
  //   loginresponse = jsonDecode(jsonBody);
  //   print(jsonBody);
  //   print(loginresponse["status"]);
  //   print(loginresponse["message"]);
  //
  //   var statusval=loginresponse["status"].toString();
  //
  //
  //   return statusval;
  //
  // }



}
