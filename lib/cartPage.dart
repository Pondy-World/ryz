import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:localstorage/localstorage.dart';
import 'package:ryz/AppState.dart';
import 'package:ryz/addAddress.dart';
import 'package:ryz/controllers/cartController.dart';
import 'package:ryz/controllers/cartDataController.dart';
import 'package:ryz/controllers/orderController.dart';
import 'package:ryz/login.dart';

var selectedWidgetMarker;

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  CartDataController cartDataController = new CartDataController();
  OrderController orderController = new OrderController();
  var cartIDs = [];
  num cartTotal = 0;

  var addressString;

  getCartData() async {
    cartTotal = 0;

    await cartDataController.cartProductRequest();
    print(cartDataController.cartProducts.length);
    for (var product in cartDataController.cartProducts) {

      cartTotal = cartTotal + (double.parse(product['price']) * product['count'].toInt());
      print(cartTotal.toString());
    }
    setState(() {});
  }

  getAddress() async {
    final LocalStorage storage = new LocalStorage('ryxstorage');
    addressString = await storage.getItem("addressdetails");
    print("addressString");
    print(addressString);
    print("addressString");
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    selectedWidgetMarker = 1;
    super.initState();
    getCartData();
    getAddress();
  }

  @override
  Widget build(BuildContext context) {
    return (cartDataController.cartProducts.isEmpty)
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
                                    cartDataController.cartProducts[index]['imgurlval'],
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
                                                cartDataController.cartProducts[index]['name'],
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            Text(cartDataController.cartProducts[index]['price']),
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

                                                var count = cartDataController.cartProducts[index]['count'];

                                                if (count == 1) {
                                                  // await CartController().deleteCrtProduct(procartobj.cartproducts[index]['id'].toString());

                                                  await CartControllerSelf().deleteProduct(cartDataController.cartProducts[index]['id'].toString());
                                                  await getCartData();
                                                } else {
                                                  count = count - 1;

                                                  var pdvproduct = CrtPds2(
                                                    id: cartDataController.cartProducts[index]['id'],
                                                    name: cartDataController.cartProducts[index]['name'],
                                                    amount: cartDataController.cartProducts[index]['amount'],
                                                    count: count,
                                                    imageURLValue: cartDataController.cartProducts[index]['imgurlval'],
                                                    price: cartDataController.cartProducts[index]['price'],
                                                    offer: cartDataController.cartProducts[index]['offer'],
                                                    offerPrice: cartDataController.cartProducts[index]['offerprice'],
                                                    weight: cartDataController.cartProducts[index]['weight'],
                                                  );

                                                  await CartControllerSelf().insertProduct(pdvproduct);

                                                  await getCartData();
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
                                                cartDataController.cartProducts[index]['count'].toString(),
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

                                                var count = cartDataController.cartProducts[index]['count'];

                                                count = count + 1;

                                                var pdvproduct = CrtPds2(
                                                  id: cartDataController.cartProducts[index]['id'],
                                                  name: cartDataController.cartProducts[index]['name'],
                                                  amount: cartDataController.cartProducts[index]['amount'],
                                                  count: count,
                                                  imageURLValue: cartDataController.cartProducts[index]['imgurlval'],
                                                  price: cartDataController.cartProducts[index]['price'],
                                                  offer: cartDataController.cartProducts[index]['offer'],
                                                  offerPrice: cartDataController.cartProducts[index]['offerprice'],
                                                  weight: cartDataController.cartProducts[index]['weight'],
                                                );

                                                await CartControllerSelf().insertProduct(pdvproduct);

                                                await getCartData();
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
                      childCount: cartDataController.cartProducts.length,
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
                                  (addressString == null)
                                      ? ""
                                      : addressString['doorno'] +
                                          " " +
                                          addressString['addressa'] +
                                          " " +
                                          addressString['addressb'] +
                                          " " +
                                          addressString['landmark'] +
                                          " " +
                                          addressString['city'] +
                                          " " +
                                          addressString['pincode'],
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
                                              addressString = val;
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
                                    "Rs." + cartTotal.toString(),
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
                                        } else {
                                          setState(() {
                                            addressString = val;
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

                                      var success = await orderController.addOrder(orderData: cartDataController.cartProducts, total: cartTotal);

                                      if (success == "true") {
                                        Fluttertoast.showToast(
                                            msg: "Order Placed Successfully",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            fontSize: 16.0);

                                        final LocalStorage storage = new LocalStorage('ryxstorage');
                                        storage.deleteItem("cartelements");
                                        getCartData();
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
