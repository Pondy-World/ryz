import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:localstorage/localstorage.dart';
import 'package:ryz/AppState.dart';
import 'package:ryz/addaddress.dart';
import 'package:ryz/controllers/cartcontroller.dart';
import 'package:ryz/controllers/cartdatacontroller.dart';
import 'package:ryz/controllers/ordercontroller.dart';
import 'package:ryz/login.dart';

var selectedWidgetMarker;

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  CartDataController procartobj = new CartDataController();
  OrderController ordercontobj = new OrderController();
  var cartids = [];
  num carttotal = 0;

  var addressstring;

  getcartdata() async {
    carttotal = 0;

    await procartobj.cartProductRequest();
    print(procartobj.cartproducts.length);
    for (var cartpds in procartobj.cartproducts) {
      // print(cartpds['id']);
      // cartids.add(cartpds['id']);

      carttotal = carttotal + (double.parse(cartpds['price']) * cartpds['count'].toInt());
      print("to oucnter");
      print(carttotal.toString());
    }
    setState(() {});
  }

  getAddress() async {
    final LocalStorage storage = new LocalStorage('ryxstorage');
    addressstring = await storage.getItem("addressdetails");
    print("addressstring");
    print(addressstring);
    print("addressstring");
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    selectedWidgetMarker = 1;
    super.initState();
    getcartdata();
    getAddress();
  }

  @override
  Widget build(BuildContext context) {
    return (procartobj.cartproducts.isEmpty)
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text("No Products in cart"),
            ),
          )
        : Stack(
            children: [
              CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 5,
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        var pricetot = double.parse(procartobj.cartproducts[index]['price']) * procartobj.cartproducts[index]['count'];
                        return Container(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IntrinsicHeight(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.network(
                                    procartobj.cartproducts[index]['imgurlval'],
                                    width: 100,
                                    height: 100,
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 5, right: 5),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                procartobj.cartproducts[index]['name'],
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            Text(procartobj.cartproducts[index]['price']),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            InkWell(
                                              onTap: () async {
                                                print("Minus one");

                                                var count = procartobj.cartproducts[index]['count'];

                                                if (count == 1) {
                                                  // await CartController().deleteCrtProduct(procartobj.cartproducts[index]['id'].toString());

                                                  await CartControllerSelf().deleteProduct(procartobj.cartproducts[index]['id'].toString());
                                                  await getcartdata();
                                                } else {
                                                  count = count - 1;

                                                  var pdvproduct = CrtPds2(
                                                    id: procartobj.cartproducts[index]['id'],
                                                    name: procartobj.cartproducts[index]['name'],
                                                    amount: procartobj.cartproducts[index]['amount'],
                                                    count: count,
                                                    imgurlval: procartobj.cartproducts[index]['imgurlval'],
                                                    price: procartobj.cartproducts[index]['price'],
                                                    offer: procartobj.cartproducts[index]['offer'],
                                                    offerprice: procartobj.cartproducts[index]['offerprice'],
                                                    weight: procartobj.cartproducts[index]['weight'],
                                                  );

                                                  await CartControllerSelf().insertProduct(pdvproduct);

                                                  await getcartdata();
                                                }
                                              },
                                              child: Icon(
                                                Icons.remove_circle_outline,
                                                color: Colors.blue,
                                                size: 30,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(right: 10, left: 10),
                                              child: Text(
                                                procartobj.cartproducts[index]['count'].toString(),
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontFamily: "Lato",
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    backgroundColor: Colors.white),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                print("Plus one");

                                                var count = procartobj.cartproducts[index]['count'];

                                                count = count + 1;

                                                var pdvproduct = CrtPds2(
                                                  id: procartobj.cartproducts[index]['id'],
                                                  name: procartobj.cartproducts[index]['name'],
                                                  amount: procartobj.cartproducts[index]['amount'],
                                                  count: count,
                                                  imgurlval: procartobj.cartproducts[index]['imgurlval'],
                                                  price: procartobj.cartproducts[index]['price'],
                                                  offer: procartobj.cartproducts[index]['offer'],
                                                  offerprice: procartobj.cartproducts[index]['offerprice'],
                                                  weight: procartobj.cartproducts[index]['weight'],
                                                );

                                                await CartControllerSelf().insertProduct(pdvproduct);

                                                await getcartdata();
                                              },
                                              child: Icon(
                                                Icons.add_circle_outline_outlined,
                                                color: Colors.blue,
                                                size: 30,
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      childCount: procartobj.cartproducts.length,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 100,
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 15, right: 15),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.blue,
                                ),
                                Expanded(
                                    child: Text(
                                  (addressstring == null)
                                      ? ""
                                      : addressstring['doorno'] +
                                          " " +
                                          addressstring['addressa'] +
                                          " " +
                                          addressstring['addressb'] +
                                          " " +
                                          addressstring['landmark'] +
                                          " " +
                                          addressstring['city'] +
                                          " " +
                                          addressstring['pincode'],
                                )),
                                InkWell(
                                    onTap: () {
                                      if (!RyzAppState().isLogin) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => LoginMain()),
                                        );
                                      } else {
                                        showDialog(
                                          context: context,
                                          builder: (context) => StatefulBuilder(builder: (context, setState) {
                                            return AddAddressMain();
                                          }),
                                        ).then((val) {
                                          if (val == null) {
                                            return;
                                          } else {
                                            setState(() {
                                              addressstring = val;
                                            });
                                          }
                                        });
                                      }
                                    },
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Text(
                                          "Change",
                                          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 17),
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                          Divider(
                            height: 10,
                            color: Colors.blueGrey,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "Cart Value",
                                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "Rs." + carttotal.toString(),
                                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.blueGrey),
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () async {
                                  print("add order Pressed");
                                  final LocalStorage storage = new LocalStorage('ryxstorage');

                                  if (!RyzAppState().isLogin) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => LoginMain()),
                                    );
                                  } else {
                                    if (storage.getItem("addressdetails") == null) {
                                      showDialog(
                                        context: context,
                                        builder: (context) => StatefulBuilder(builder: (context, setState) {
                                          return AddAddressMain();
                                        }),
                                      ).then((val) {
                                        if (val == null) {
                                          // addressstring="";
                                        } else {
                                          setState(() {
                                            addressstring = val;
                                          });
                                        }
                                      });
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: "Please wait",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          fontSize: 16.0);

                                      var success = await ordercontobj.addOrder(procartobj.cartproducts, carttotal);

                                      if (success == "true") {
                                        Fluttertoast.showToast(
                                            msg: "Order Placed Successfully",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            fontSize: 16.0);

                                        final LocalStorage storage = new LocalStorage('ryxstorage');
                                        storage.deleteItem("cartelements");
                                        getcartdata();
                                        setState(() {});
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: "Something went wrong",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            fontSize: 16.0);
                                      }
                                    }
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Center(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Place Order",
                                      style: TextStyle(color: Colors.white, fontSize: 22),
                                    ),
                                  )),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}
