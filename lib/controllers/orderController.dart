import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:ryz/controllers/baseValues.dart';

import '../AppState.dart';

class OrderController {
  Auth auth = new Auth();
  String newStr = "";
  var addOrderResponse = {};
  final LocalStorage storage = new LocalStorage('ryxstorage');

  Future<String> addOrder({required List orderData, required num total}) async {
    var url = Uri.parse(baseurl + 'order/saveorder.php');
    print(url);
    String basicAuth = 'Basic ' + base64Encode(utf8.encode((auth.authName + ':' + auth.authPass)));

    var addressData = await storage.getItem("addressdetails");

    var status;

    for (var orders in orderData) {
      print(orders);
    }

    List<int> productIds = [];
    List<int> productQuantity = [];
    List<num> productPrice = [];
    List<String> productNames = [];

    orderData.asMap().forEach((index, value) {
      productIds.add(int.parse(value["id"]));
      productQuantity.add(value["count"]);
      productPrice.add(num.parse(value["price"]));
      productNames.add(value["name"]);
    });

    var sendData = {
      'store_id': "10",
      'customer_id': RyzAppState().id.toString(),
      'name': RyzAppState().name.toString(),
      'email': RyzAppState().email.toString(),
      'phone': int.parse(RyzAppState().phone),
      'street': addressData['addresssa'].toString(),
      'city': addressData['addressb'].toString(),
      'state': addressData['landmark'].toString(),
      'pincode': int.parse(addressData['pincode']),
      'amount': total,
      'merchant_order_id': 'merchant_order_id',
      'payment_status': 'pending',
      'payment_id': 'payment_id',
      'added_on': DateTime.now().toString(),
      'product_id': productIds.toString(),
      'product_quantity': productQuantity.toString(),
      'product_amounts': productPrice.toString(),
      'product_names': productNames.toString(),
      'order_status': 'In Review',
    };

    print(sendData);

    try {
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': basicAuth,
        },
        body: jsonEncode(sendData),
      );

      var jsonBody = response.body;
      print(jsonBody);
      addOrderResponse = jsonDecode(jsonBody);
      print(addOrderResponse["status"]);
      print(addOrderResponse["message"]);

      status = addOrderResponse["status"].toString();
    } catch (e) {
      print(e);
    }

    return status;
  }

  var orderList;

  Future<String> fetchOrders({required int customerID}) async {
    var url = Uri.parse(baseurl + 'order/vieworder.php?custid=$customerID');
    print(url);
    String basicAuth = 'Basic ' + base64Encode(utf8.encode((auth.authName + ':' + auth.authPass)));

    await http.get(
      url,
      headers: <String, String>{'Content-Type': 'application/x-www-form-urlencoded', 'Authorization': basicAuth},
    ).then((response) => orderList = jsonDecode(response.body));

    print(orderList);
    var status = "true";

    return status;
  }

  var orderDetails;

  Future<String> fetchOrderDetails({required String orderID}) async {
    var url = Uri.parse(baseurl + 'order/vieworderdetail.php?orderid=$orderID');
    print(url);
    String basicAuth = 'Basic ' + base64Encode(utf8.encode((auth.authName + ':' + auth.authPass)));

    var response = await http.get(
      url,
      headers: <String, String>{'Content-Type': 'application/x-www-form-urlencoded', 'Authorization': basicAuth},
    );

    var jsonBody = response.body;
    print(jsonBody);
    var dummyList = jsonDecode(jsonBody);
    orderDetails = dummyList['data'];
    print(orderDetails);

    var status = "oString();";

    return status;
  }
}
