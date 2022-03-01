import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:ryz/controllers/ordercontroller.dart';

class OrderDetailsMain extends StatelessWidget {
  final selectedorder;

  const OrderDetailsMain({Key? key, this.selectedorder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrderDetails(
      selectedorder: selectedorder,
    );
  }
}

class OrderDetails extends StatefulWidget {
  final selectedorder;

  const OrderDetails({Key? key, this.selectedorder}) : super(key: key);

  @override
  _OrderDetailsState createState() => _OrderDetailsState(selectedorder);
}

class _OrderDetailsState extends State<OrderDetails> {
  final selectedorder;

  OrderController ordercontobj = new OrderController();

  _OrderDetailsState(this.selectedorder);

  getData() async {
    final LocalStorage storage = new LocalStorage('ryxstorage');

    await ordercontobj.fetchOrderdetails(selectedorder['id']);

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
                                selectedorder['service_name'],
                                style: TextStyle(
                                    color: Colors.blue, fontSize: 20),
                              ),
                              Text(
                                selectedorder['service_city'],
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 15),
                              ),
                              Text(
                                "Total Value: " +
                                    selectedorder['amount'].toString(),
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 15),
                              ),
                            ],
                          ),
                          Text(
                            selectedorder['order_status'].toString(),
                            textAlign: TextAlign.right,
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ],
                      ),
                      Text(
                        "Order id: " + selectedorder['id'].toString(),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
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
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blue
                  ),
                ),
              ),
            ),
          ),

          (ordercontobj.orderdetails == null)
              ? SliverToBoxAdapter(
                  child: Center(
                      child: CircularProgressIndicator(
                    color: Colors.blue,
                  )),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    var singlepd = ordercontobj.orderdetails[index];
                    var tot=  double.parse(singlepd['product_amount'])  *  double.parse(singlepd['product_quantity']);
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: ListTile(
                          title: Text(
                            singlepd['title'],
                            style: TextStyle(
                                color: Colors.black,
                            ),
                          ),

                          subtitle: Text(
                            singlepd['product_amount'] +" * " +singlepd['product_quantity'],
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),

                          trailing: Text(
                            tot.toString(),
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    );
                  }, childCount: ordercontobj.orderdetails.length),
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
