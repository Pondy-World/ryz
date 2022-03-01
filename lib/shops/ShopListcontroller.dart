import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:ryz/controllers/baseval.dart';
import 'package:http/http.dart' as http;
import 'package:ryz/controllers/authcontroller.dart';

class ShopListController {
  String newStr = "";
  Auth auth= new Auth();


  var shoplistresponse={};

  void strmeth(String val_a) {
    this.newStr = val_a;
  }

  Future<Map> fetchAllShops() async {
    var url = Uri.parse(baseurl + 'Shops/shoplist.php');
    print(url);
    String basicAuth = 'Basic ' + base64Encode(utf8.encode((auth.authname + ':' + auth.authpass)));

    var response = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': basicAuth
    },);

    var jsonBody = response.body;
    shoplistresponse = jsonDecode(jsonBody);
    return shoplistresponse;
  }


  Future<String> fetchShopsCat(String headid) async {

    var url = Uri.parse(baseurl + 'Shops/shoplistallcat.php?catid=$headid');
    print(url);
    String basicAuth = 'Basic ' + base64Encode(utf8.encode((auth.authname + ':' + auth.authpass)));

    var response = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': basicAuth
    },);

    var jsonBody = response.body;
    shoplistresponse = jsonDecode(jsonBody);
    print(jsonBody);
    // print(loginresponse["status"]);
    print(shoplistresponse["data"]);

    print(shoplistresponse["data"][0]["id"]);

    var statusval="oString();";

    return statusval;

  }




}
