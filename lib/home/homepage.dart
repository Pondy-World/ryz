import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ryz/home/homepagecontroller.dart';
import 'package:ryz/productlst.dart';
import 'package:ryz/profileonlyshop/poindex.dart';
import 'package:ryz/shops/ShopListcontroller.dart';
import 'package:ryz/shops/shoplistcat.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController homeController = new HomeController();

  fetchData() async {
    print("*****");
    print(homeController.categoryResults);
    await homeController.fetchCategories();
    setState(() {});
  }

  ShopListController shopController = new ShopListController();

  fetchDataShop() async {
    print("*****");
    print(shopController.shoplistresponse);
    await shopController.fetchAllShops();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
    fetchDataShop();
  }

  var name = [
    "Groceries",
    "Vegetables",
    "Meat & Fish",
    "Food delivery",
    "Medicines",
    "Pick & Drop",
    "Pet Supplies",
  ];

  var shopcount = [
    "24 shops",
    "20 shops",
    "28 shops",
    "14 shops",
    "56 shops",
    "89 shops",
    "13 shops",
    "26 shops",
  ];

  var bannerimagae = [
    "images/phot.jpg",
    "images/phot.jpg",
    "images/phot.jpg",
    "images/phot.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width);
    print(MediaQuery.of(context).size.height);

    Widget smallScreen() {
      return (homeController.categoryResults["data"] == null)
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.teal,
              ),
            )
          : CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 10,
                  ),
                ),

                SliverToBoxAdapter(
                  child: CarouselSlider(
                    options: CarouselOptions(height: 150.0),
                    items: bannerimagae.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(
                                  // color: Colors.amber
                                  ),
                              child: Image.asset(i));
                        },
                      );
                    }).toList(),
                  ),
                ),
                // SliverToBoxAdapter(
                //   child: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: Image.asset("images/dtd.jpeg"),
                //   ),
                // ),

                SliverGrid(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200.0,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    childAspectRatio: 1.0,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ShopListCat(homeController.categoryResults["data"][index]["category_name"],
                                        homeController.categoryResults["data"][index]["id"], homeController.categoryResults["data"][index]["catg_image"])));
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.network(
                                    "https://ryz.co.in/admin/upload/category/" + homeController.categoryResults["data"][index]["catg_image"],
                                    width: 100,
                                  ),
                                  Text(
                                    homeController.categoryResults["data"][index]["category_name"],
                                    style: TextStyle(fontSize: 20, color: Colors.black, fontFamily: "Lato"),
                                  ),
                                  Text(
                                    shopcount[index],
                                    style: TextStyle(fontSize: 13, color: Colors.black45, fontFamily: "Lato"),
                                  ),
                                ],
                              )),
                        ),
                      );
                    },
                    childCount: homeController.categoryResults["data"].length,
                  ),
                ),
              ],
            );
    }

    Widget largeScreen() {
      return (homeController.categoryResults["data"] == null)
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.teal,
              ),
            )
          : CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 10,
                  ),
                ),
                SliverToBoxAdapter(
                  child: CarouselSlider(
                    options: CarouselOptions(height: MediaQuery.of(context).size.height / 2, autoPlay: true, autoPlayInterval: Duration(seconds: 3)),
                    items: bannerimagae.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(
                                  // color: Colors.amber
                                  ),
                              child: Image.asset(i));
                        },
                      );
                    }).toList(),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 20,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Center(
                    child: Container(
                      height: 175,
                      width: MediaQuery.of(context).size.width - 200,
                      child: ListView.builder(
                          itemCount: homeController.categoryResults["data"].length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: InkWell(
                                // onTap: (){
                                //   Navigator.push(
                                //       context,
                                //       MaterialPageRoute(
                                //           builder: (context) => ShopListCatMain(homecont.catresult["data"][index]["category_name"], homecont.catresult["data"][index]["id"],)
                                //       )
                                //   );
                                // },

                                child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.blue.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 20, left: 20),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Image.network(
                                            "https://ryz.co.in/admin/upload/category/" + homeController.categoryResults["data"][index]["categ_banner"],
                                            width: 100,
                                          ),
                                          Text(
                                            homeController.categoryResults["data"][index]["category_name"],
                                            style: TextStyle(fontSize: 15, color: Colors.blueGrey, fontFamily: "Lato"),
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                            );
                          }),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 25,
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int mainindex) {
                      return Column(
                        children: [
                          Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width - 200,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    homeController.categoryResults["data"][mainindex]["category_name"],
                                    style: TextStyle(color: Colors.black, fontSize: 25),
                                  ),
                                  ElevatedButton(onPressed: () {}, child: Text("View More"))
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          (shopController.shoplistresponse["data"] == null)
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.teal,
                                  ),
                                )
                              : Center(
                                  child: Container(
                                    height: 250,
                                    width: MediaQuery.of(context).size.width - 200,
                                    child: ListView.builder(
                                        itemCount: shopController.shoplistresponse["data"].length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (BuildContext context, int index) {
                                          return (shopController.shoplistresponse["data"][index]["category_name"] ==
                                                  homeController.categoryResults["data"][mainindex]["category_name"])
                                              ? Padding(
                                                  padding: const EdgeInsets.all(10.0),
                                                  child: InkWell(
                                                    onTap: () {
                                                      print(shopController.shoplistresponse["data"][index]["shoptype"]);
                                                      if (shopController.shoplistresponse["data"][index]["shoptype"] == "1") {
                                                        print("normal shop");
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) => ProfileOnlyIndexMain(
                                                                    selectedshop: shopController.shoplistresponse["data"][index],
                                                                  )),
                                                        );
                                                      } else {
                                                        print("order shop");
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(builder: (context) => ProductListMain()),
                                                        );
                                                      }
                                                    },
                                                    child: Container(
                                                        width: 300,
                                                        height: 300,
                                                        decoration: BoxDecoration(
                                                          // color: Colors.blue.withOpacity(0.1),
                                                          borderRadius: BorderRadius.circular(12),
                                                          border: Border.all(color: Colors.black12),
                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(right: 20, left: 20, bottom: 15, top: 15),
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: [
                                                              Image.network(
                                                                "https://ryz.pondyworld.com/admin/upload/" +
                                                                    shopController.shoplistresponse["data"][index]["image"],
                                                                // width: 250,
                                                                height: 160,
                                                              ),
                                                              Text(
                                                                shopController.shoplistresponse["data"][index]["shop_name"],
                                                                textAlign: TextAlign.center,
                                                                overflow: TextOverflow.ellipsis,
                                                                style: TextStyle(fontSize: 15, color: Colors.blueGrey, fontFamily: "Lato"),
                                                              ),
                                                            ],
                                                          ),
                                                        )),
                                                  ),
                                                )
                                              : SizedBox(
                                                  height: 0,
                                                );
                                        }),
                                  ),
                                ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      );
                    },
                    childCount: homeController.categoryResults["data"].length,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    height: 70,
                    color: Color(0xff152238),
                    child: Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width - 200,
                        child: Row(
                          children: [
                            Text(
                              "RYZ",
                              style: TextStyle(color: Colors.white, fontSize: 25),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
    }

    return (MediaQuery.of(context).size.width > 800) ? largeScreen() : smallScreen();
  }
}
