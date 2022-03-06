import 'package:flutter/material.dart';
import 'package:ryz/AppState.dart';
import 'package:ryz/controllers/orderController.dart';
import 'package:ryz/orderDetails.dart';

class OrderList extends StatefulWidget {
  const OrderList({Key? key}) : super(key: key);

  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  String displayText = "No orders to show";
  bool login = RyzAppState().isLogin;
  OrderController orderController = new OrderController();

  getData() async {
    if (RyzAppState().isLogin) {
      int loginID = int.parse(RyzAppState().id);
      print(loginID);
      await orderController.fetchOrders(customerID: loginID);
      setState(() {});
    }
    setState(() {});
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
        (login)
            ? (orderController.orderList == null)
                ? SliverToBoxAdapter(
                    child: Center(
                        child: CircularProgressIndicator(
                      color: Colors.blue,
                    )),
                  )
                : SliverList(
                    delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                      var singleOrder = orderController.orderList["data"][index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => OrderDetailsMain(selectedOrder: singleOrder)),
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
                                            singleOrder['service_name'],
                                            style: TextStyle(color: Colors.black, fontSize: 20),
                                          ),
                                          Text(
                                            singleOrder['service_city'],
                                            style: TextStyle(color: Colors.grey, fontSize: 15),
                                          ),
                                          Text(
                                            "Total Value: " + singleOrder['amount'].toString(),
                                            style: TextStyle(color: Colors.grey, fontSize: 15),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        singleOrder['order_status'].toString(),
                                        textAlign: TextAlign.right,
                                        style: TextStyle(color: Colors.black, fontSize: 15),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "Order id: " + singleOrder['id'].toString(),
                                    style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                        ),
                      );
                    }, childCount: orderController.orderList["data"].length),
                  )
            : SliverToBoxAdapter(
                child: Center(
                child: Text(
                  displayText,
                ),
              )),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 10,
          ),
        ),
      ],
    );
  }
}
