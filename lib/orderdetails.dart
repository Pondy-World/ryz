import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ryz/controllers/orderController.dart';

class OrderDetailsMain extends StatelessWidget {
  final selectedOrder;

  const OrderDetailsMain({Key? key, this.selectedOrder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrderDetails(
      selectedOrder: selectedOrder,
    );
  }
}

class OrderDetails extends StatefulWidget {
  final selectedOrder;

  const OrderDetails({Key? key, this.selectedOrder}) : super(key: key);

  @override
  _OrderDetailsState createState() => _OrderDetailsState(selectedOrder);
}

class _OrderDetailsState extends State<OrderDetails> {
  final selectedOrder;

  OrderController orderController = new OrderController();

  _OrderDetailsState(this.selectedOrder);

  getData() async {
    await orderController.fetchOrderDetails(orderID: selectedOrder['id'].toString());

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
    return Scaffold(
      appBar: AppBar(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: 5,
            ),
          ),
          SliverToBoxAdapter(
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
                                selectedOrder['service_name'],
                                style: TextStyle(color: Colors.blue, fontSize: 20),
                              ),
                              Text(
                                selectedOrder['service_city'],
                                style: TextStyle(color: Colors.grey, fontSize: 15),
                              ),
                              Text(
                                "Total Value: " + selectedOrder['amount'].toString() + " ₹",
                                style: TextStyle(color: Colors.grey, fontSize: 15),
                              ),
                            ],
                          ),
                          Text(
                            selectedOrder['order_status'].toString(),
                            textAlign: TextAlign.right,
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ],
                      ),
                      Text(
                        "Order id: " + selectedOrder['id'].toString(),
                        style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
            ),
          ),
          SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Order details",
                  style: TextStyle(fontSize: 18, color: Colors.blue),
                ),
              ),
            ),
          ),
          (orderController.orderDetails == null)
              ? SliverToBoxAdapter(
                  child: Center(
                      child: CircularProgressIndicator(
                    color: Colors.blue,
                  )),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                    var single = orderController.orderDetails[0];
                    List<dynamic> productAmounts = jsonDecode(single['product_amounts']);
                    List<dynamic> productQuantity = jsonDecode(single['product_quantity']);
                    List<String> productTitles = single['title'].toString().replaceAll("[", "").replaceAll("]", "").split(", ");
                    num tot = productAmounts[index] * productQuantity[index];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: ListTile(
                          title: Text(
                            productTitles[index],
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            "per Unit: " + (productAmounts[index]).toString(),
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          trailing: Text(
                            tot.toString() + " ₹",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    );
                  }, childCount: jsonDecode(orderController.orderDetails[0]["product_amounts"]).length),
                ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Total: ${selectedOrder['amount'].toString()} ₹",
                style: TextStyle(fontSize: 18, color: Colors.blue),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 10,
            ),
          ),
        ],
      ),
    );
  }
}
