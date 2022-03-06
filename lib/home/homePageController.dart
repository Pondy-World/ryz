import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ryz/controllers/baseValues.dart';

class HomeController {
  String newStr = "";
  Auth auth = new Auth();

  var categoryResults = {};

  void strMethod(String valA) {
    this.newStr = valA;
  }

  Future fetchCategories() async {
    var url = Uri.parse(baseurl + 'Category/category.php');
    print(url);
    String basicAuth = 'Basic ' + base64Encode(utf8.encode((auth.authName + ':' + auth.authPass)));

    var response = await http.get(
      url,
      headers: <String, String>{'Content-Type': 'application/x-www-form-urlencoded', 'Authorization': basicAuth},
    );

    var jsonBody = response.body;
    print(jsonBody);
    categoryResults = jsonDecode(jsonBody);

    print(categoryResults["data"]);
    print(categoryResults["data"][0]["category_name"]);
  }
}
