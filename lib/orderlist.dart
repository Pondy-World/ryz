import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:ryz/AppState.dart';
import 'package:ryz/controllers/ordercontroller.dart';
import 'package:ryz/orderdetails.dart';

class OrderList extends StatefulWidget {
  const OrderList({Key? key}) : super(key: key);

  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {

  var displaytext= "No orders to show";
  var login=RyzAppState().isLogin;
  OrderController ordercontobj = new OrderController();

  getData() async {
    final LocalStorage storage = new LocalStorage('ryxstorage');

    if(RyzAppState().isLogin){
      var loginID= RyzAppState().id;
      print(loginID);
      await ordercontobj.fetchOrders(loginID);
      setState(() {});
    }
    setState(() {

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: SizedBox(
            height: 5,
          ),
        ),

        (login)?

        (ordercontobj.orderlist==null)?

        SliverToBoxAdapter(
          child: Center(
            child:CircularProgressIndicator(
              color: Colors.blue,
            )
          ),
        ):


        SliverList(
          delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index){
                    var singleorder= ordercontobj.orderlist["data"][index];
                return InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OrderDetailsMain(selectedorder: singleorder)
                      ),
                    );
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [

                                  Text(
                                    singleorder['service_name'],
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20
                                      ),
                                  ),

                                  Text(
                                    singleorder['service_city'],
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15
                                    ),
                                  ),

                                  Text(
                                    "Total Value: "+ singleorder['amount'].toString(),
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15
                                    ),
                                  ),


                                ],
                              ),
                              Text(
                                singleorder['order_status'].toString(),
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "Order id: " + singleorder['id'].toString(),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      )
                    ),
                  ),
                );
              },childCount: ordercontobj.orderlist["data"].length
          ),
        )
            :

        SliverToBoxAdapter(
          child: Center(
            child: Text(
              displaytext,
            ),
          )
        ),



        SliverToBoxAdapter(
          child: SizedBox(height: 10,),
        ),


      ],
    );
  }
}
