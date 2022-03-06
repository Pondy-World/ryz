import 'dart:convert';

import 'package:ryz/controllers/baseValues.dart';
import 'package:http/http.dart' as http;

class ProductController {
  String newStr = "";
  Auth auth= new Auth();

  var productList=[];

  void stringMethod({required String valA}) {
    this.newStr = valA;
  }

  Future<String> fetchproducts() async {
    var url = Uri.parse(baseurl + 'Products/productlist.php');
    print(url);
    String basicAuth = 'Basic ' + base64Encode(utf8.encode((auth.authName + ':' + auth.authPass)));

    var response = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': basicAuth
    },);

    var jsonBody = response.body;
    var dumlist = jsonDecode(jsonBody);
     productList = dumlist['data'];
    print(jsonBody);
    // print(loginresponse["status"]);
    print(productList);

    print(productList[0]["id"]);

    var statusval="oString();";

    return statusval;

  }




}
