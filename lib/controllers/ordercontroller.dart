import 'dart:convert';
import 'package:localstorage/localstorage.dart';
import 'package:ryz/controllers/baseval.dart';
import 'package:http/http.dart' as http;

import '../AppState.dart';

class OrderController {

  Auth auth= new Auth();
  String newStr = "";
  var addorderresponce={};
  final LocalStorage storage = new LocalStorage('ryxstorage');


  Future<String> addOrder(List orderdatas, num total) async {

    var url = Uri.parse(baseurl + 'order/saveorder.php');
    print(url);
    String basicAuth = 'Basic ' + base64Encode(utf8.encode((auth.authname + ':' + auth.authpass)));

    var addressData= await storage.getItem("addressdetails");

    var statusval;

    var localdatas = [];

    for(var orders in orderdatas){
      print(orders);
    }

    List<int>productIds = [];
    List<int>productQuantity = [];
    List<num>productPrice = [];
    List<String> productNames = [];

    orderdatas.asMap().forEach((index, value) {
      productIds.add(int.parse(value["id"]));
      productQuantity.add(value["count"]);
      productPrice.add(num.parse(value["price"]));
      productNames.add(value["name"]);
    });


    var senddata= {
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
      'payment_status': 'payment_status',
      'payment_id': 'payment_id',
      'added_on': DateTime.now().toString(),
      'product_id': productIds.toString(),
      'product_quantity': productQuantity.toString(),
      'product_amounts': productPrice.toString(),
      'product_names': productNames.toString(),
      'order_status': 'In Progress',

      // for(var orders in localdatas)
      //   orders['indexdata']: orders['datas'],

    };

    print(senddata);

    try{
      var response = await http.post(url, headers: <String, String>{
        // 'Content-Type': 'application/x-www-form-urlencoded',
        'Content-Type': 'application/json',
        'Authorization': basicAuth,
      }, body: jsonEncode(senddata),
      );

      var jsonBody = response.body;
      print(jsonBody);
      addorderresponce = jsonDecode(jsonBody);
      print(addorderresponce["status"]);
      print(addorderresponce["message"]);

       statusval=addorderresponce["status"].toString();
    }catch(e){
      print(e);
    }


    return statusval;

  }



  var orderlist;

  Future<String> fetchOrders(var custid) async {

    var url = Uri.parse(baseurl + 'order/vieworder.php?custid=$custid');
    print(url);
    String basicAuth = 'Basic ' + base64Encode(utf8.encode((auth.authname + ':' + auth.authpass)));

    await http.get(url, headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': basicAuth
    },).then((response) => orderlist = jsonDecode(response.body));

    print(orderlist);
    // print(loginresponse["status"]);
    print(orderlist);

    // print(productlist[0]["id"]);

    var statusval="true";

    return statusval;

  }



  var orderdetails;

  Future<String> fetchOrderdetails(var orderid) async {

    var url = Uri.parse(baseurl + 'order/vieworderdetail.php?orderid=$orderid');
    print(url);
    String basicAuth = 'Basic ' + base64Encode(utf8.encode((auth.authname + ':' + auth.authpass)));

    var response = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': basicAuth
    },);

    var jsonBody = response.body;
    print(jsonBody);
    var dumlist = jsonDecode(jsonBody);
    orderdetails = dumlist['data'];
    // print(loginresponse["status"]);
    print(orderdetails);

    // print(productlist[0]["id"]);

    var statusval="oString();";

    return statusval;

  }



}
