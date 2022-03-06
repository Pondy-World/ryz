import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:ryz/controllers/baseValues.dart';

class AddressController {
  Auth auth = new Auth();
  String newStr = "";

  final doorNo = TextEditingController();
  final addressA = TextEditingController();
  final addressB = TextEditingController();
  final landmark = TextEditingController();
  final city = TextEditingController();
  final pincode = TextEditingController();

  var addAddressResponse = {};

  Future<String> addAddress() async {
    var url = Uri.parse(baseurl + 'address/addaddress.php');
    print(url);
    String basicAuth = 'Basic ' + base64Encode(utf8.encode((auth.authName + ':' + auth.authPass)));
    var response = await http.post(url, headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': basicAuth
    }, body: {
      'customerid': "10",
      'doorno': doorNo.text,
      'addressa': addressA.text,
      'addressb': addressB.text,
      'landmark': landmark.text,
      'city': city.text,
      'pincode': pincode.text
    });

    var jsonBody = response.body;
    addAddressResponse = jsonDecode(jsonBody);
    print(jsonBody);
    print(addAddressResponse["status"]);
    print(addAddressResponse["message"]);

    var status = addAddressResponse["status"].toString();

    return status;
  }
}
