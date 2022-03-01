import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:localstorage/localstorage.dart';
import 'package:ryz/controllers/baseval.dart';
import 'package:http/http.dart' as http;
import 'package:ryz/controllers/baseval.dart';

class AddressController {

  Auth auth= new Auth();
  String newStr = "";

  final doorno = TextEditingController();
  final addressa = TextEditingController();
  final addressb = TextEditingController();
  final landmark = TextEditingController();
  final city = TextEditingController();
  final pincode = TextEditingController();

  var addaddresresponce={};

  Future<String> addAddress() async {
    var url = Uri.parse(baseurl + 'address/addaddress.php');
    print(url);
    String basicAuth = 'Basic ' + base64Encode(utf8.encode((auth.authname + ':' + auth.authpass)));
    var response = await http.post(url, headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': basicAuth
    }, body: {
      'customerid': "10",
      'doorno': doorno.text,
      'addressa': addressa.text,
      'addressb': addressb.text,
      'landmark': landmark.text,
      'city': city.text,
      'pincode':pincode.text
    });

    var jsonBody = response.body;
    addaddresresponce = jsonDecode(jsonBody);
    print(jsonBody);
    print(addaddresresponce["status"]);
    print(addaddresresponce["message"]);

    var statusval=addaddresresponce["status"].toString();

    return statusval;

  }

}
