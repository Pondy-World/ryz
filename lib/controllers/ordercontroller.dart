import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:localstorage/localstorage.dart';
import 'package:ryz/controllers/baseval.dart';
import 'package:http/http.dart' as http;
import 'package:ryz/controllers/baseval.dart';

import '../AppState.dart';

class OrderController {

  Auth auth= new Auth();
  String newStr = "";
  var addorderresponce={};
  final LocalStorage storage = new LocalStorage('ryxstorage');


  Future<String> addOrder(List orderdatas, var total) async {

    var url = Uri.parse(baseurl + 'order/saveorder.php');
    print(url);
    String basicAuth = 'Basic ' + base64Encode(utf8.encode((auth.authname + ':' + auth.authpass)));

    var addredet= await storage.getItem("addressdetails");

    var statusval;

    var localdatas = [];

    for(var orders in orderdatas){
      print(orders);
    }

    orderdatas.asMap().forEach((index, value) {
      localdatas.add(
        {
          "id": value['id'],
          "price": value['price'],
          "count": value['count'],
        }
      );
    });


    var senddata= {
      'store_id': "10",
      'user_id': RyzAppState().id,
      'name': RyzAppState().name,
      'email': RyzAppState().email,
      'phone': RyzAppState().phone,
      'street': addredet['addressa'],
      'city': addredet['city'],
      'state': addredet['city'],
      'pincode': addredet['pincode'],
      'amount': total,
      'merchant_order_id': 'merchant_order_id',
      'payment_status': 'payment_status',
      'payment_id': 'payment_id',
      'added_on': '2021-07-30 14:59:41',
      'order_status': 'pending',
      'orderdatas': localdatas

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

    var response = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': basicAuth
    },);

    var jsonBody = response.body;
    var dumlist = jsonDecode(jsonBody);
    orderlist = dumlist['data'];
    print(jsonBody);
    // print(loginresponse["status"]);
    print(orderlist);

    // print(productlist[0]["id"]);

    var statusval="oString();";

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
