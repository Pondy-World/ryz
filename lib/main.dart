import 'package:flutter/material.dart';
import 'package:ryz/AppState.dart';
import 'package:ryz/cartpage.dart';
import 'package:ryz/controllers/cartcontroller.dart';
import 'package:ryz/home/homepage.dart';
import 'package:ryz/login.dart';
import 'package:ryz/orderlist.dart';
import 'package:ryz/profilebody.dart';
import 'package:ryz/shops/ShopListcontroller.dart';
import 'package:ryz/shops/shoplist.dart';
import 'package:search_page/search_page.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

bool isLogin = false;

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? loginStatus;

  load() {
    RyzAppState().initializePersistedState().then((value) => setState(() => loginStatus = value.getBool('ryz_isLogin') ?? false));
  }

  @override
  void initState() {
    // TODO: implement initState
    load();
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return loginStatus == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: loginStatus! ? MyHomePage() : LoginMain(),
          );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  CartControllerSelf cartController = new CartControllerSelf();

  late final List<Widget> _widgetOptions;

  bool showProfile = false;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _widgetOptions = <Widget>[HomePage(), ShopList(), CartPage(), OrderList()];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    Widget smallScreen() {
      return Scaffold(
        backgroundColor: Color(0xFFecede8),
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Row(
            children: [
              Image.asset(
                'images/logo.png',
                width: 55,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  "",
                  style: TextStyle(fontSize: 16, color: Colors.black, fontFamily: "Lato"),
                ),
              )
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search_outlined),
              onPressed: () async {
                List<Map> shops = await ShopListController().fetchAllShops().then((shopListResponse) {
                  List<Map> listContainer = [];
                  for (var shop in shopListResponse["data"]) {
                    listContainer.add(shop);
                  }
                  return listContainer;
                });
                showSearch(
                    context: context,
                    delegate: SearchPage<Map>(
                        items: shops,
                        builder: (shop) => Container(
                              color: Colors.white,
                              child: IntrinsicHeight(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // ClipRect(
                                    //   child: Container(
                                    //
                                    //     // child: Align(
                                    //     //   alignment: Alignment.center,
                                    //     //   heightFactor: 0.4,
                                    //     //   widthFactor: 0.2,
                                    //     //   child: Image.asset(
                                    //     //     "images/shopimg.jpeg",
                                    //     //     // width: width/4,
                                    //     //     height: width,
                                    //     //   ),
                                    //     // ),
                                    //
                                    //     child: ,
                                    //
                                    //   ),
                                    // ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 8),
                                      child: Image.network(
                                        "https://ryz.pondyworld.com/admin/upload/" + shop["image"],
                                        width: 100,
                                        height: 100,
                                      ),
                                    ),

                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 8),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              shop["shop_name"],
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(fontFamily: 'Lato', fontSize: 20, fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              shop["category_name"],
                                              style: TextStyle(fontSize: 17, fontWeight: FontWeight.normal, color: Colors.grey),
                                            ),
                                            Text(
                                              shop["shop_street"],
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: Colors.black, fontFamily: 'Lato'),
                                            ),
                                            Text(
                                              "Upto 50% Offers available",
                                              style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        searchLabel: 'Search Shops',
                        showItemsOnEmpty: true,
                        suggestion: Center(
                          child: Text('Filter Shops by Pin Code or Name'),
                        ),
                        filter: (shop) => [shop["shop_name"], shop["shop_pincode"]]));
              },
            ),
            IconButton(
              icon: Icon(Icons.person_outline_rounded),
              onPressed: () async {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileBody()));
              },
            ),
            IconButton(onPressed: () {
              launchURL() async => await launch("https://wa.me/+918056889971");
              launchURL();
            }, icon: Icon(Icons.whatsapp, size: 25,))
          ],
        ),

        body: _widgetOptions.elementAt(_selectedIndex),

        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.storefront,
              ),
              label: "Shops",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart_outlined,
              ),
              label: "Cart",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.local_shipping_outlined,
              ),
              label: "Orders",
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          elevation: 5,
          showUnselectedLabels: true,
          onTap: _onItemTapped,
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: (){
        //
        //     // var samppd = new CrtPds2(id: "4", name: "plop", amount: "4", count: 1, imgurlval: "aasdf", price: "5", offer: "false", offerprice: "", weight: "10");
        //     // slfcart.insertProduct(samppd);
        //     // slfcart.viewProduct();
        //
        //     // print("bef call");
        //     // print(slfcart.viewProduct());
        //     // print("aft call");
        //
        //     procartobj.cartProductRequest();
        //   },
        //   child: Text("clic"),
        // ),
      );
    }

    Widget largeScreen() {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(65.0), // here the desired height
          child: Container(
            height: 75,
            color: Colors.blue,
            child: Padding(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      _selectedIndex = 0;
                      setState(() {});
                    },
                    child: Image.asset(
                      'images/logo.png',
                      width: 60,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 50, right: 50),
                      child: Container(
                        width: 400,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: TextField(
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.text,
                            decoration: new InputDecoration(
                              border: InputBorder.none,
                              suffixIcon: Icon(
                                Icons.search,
                                color: Colors.grey,
                              ),
                              hintText: "Search for shops",
                              labelStyle: new TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.phone,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 50),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Call Us:",
                              style: TextStyle(color: Colors.amber),
                            ),
                            Text(
                              "917708690322",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      _selectedIndex = 2;
                      setState(() {});
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.shopping_cart_outlined,
                          color: Colors.white,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "My Cart",
                                style: TextStyle(color: Colors.amber),
                              ),
                              Text(
                                "₹ 0.00",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: _widgetOptions.elementAt(_selectedIndex),
      );
    }

    return (width < 800) ? smallScreen() : largeScreen();
  }
}
