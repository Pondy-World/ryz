import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:ryz/controllers/baseval.dart';
import 'package:http/http.dart' as http;
import 'package:ryz/controllers/authcontroller.dart';

class ProductController {
  String newStr = "";
  Auth auth= new Auth();

  var productlist=[];

  void strmeth(String val_a) {
    this.newStr = val_a;
  }

  Future<String> fetchproducts() async {
    var url = Uri.parse(baseurl + 'Products/productlist.php');
    print(url);
    String basicAuth = 'Basic ' + base64Encode(utf8.encode((auth.authname + ':' + auth.authpass)));

    var response = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': basicAuth
    },);

    var jsonBody = response.body;
    var dumlist = jsonDecode(jsonBody);
     productlist = dumlist['data'];
    print(jsonBody);
    // print(loginresponse["status"]);
    print(productlist);

    print(productlist[0]["id"]);

    var statusval="oString();";

    return statusval;

  }




}
