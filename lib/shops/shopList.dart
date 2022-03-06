import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ryz/productList.dart';
import 'package:ryz/profileonlyshop/poindex.dart';
import 'package:ryz/shops/ShopListController.dart';

class ShopList extends StatefulWidget {
  const ShopList({Key? key}) : super(key: key);

  @override
  _ShopListState createState() => _ShopListState();
}

class _ShopListState extends State<ShopList> {
  ShopListController shopListController = new ShopListController();

  fetchData() async {
    print("*****");
    print(shopListController.shopListResponse);
    await shopListController.fetchAllShops();
    setState(() {});
  }

  var bannerImages = [
    "images/veg.jpg",
    "images/veg.jpg",
    "images/veg.jpg",
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return (shopListController.shopListResponse["data"] == null)
        ? Center(
            child: CircularProgressIndicator(
              color: Colors.teal,
            ),
          )
        : CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 5,
                ),
              ),
              SliverToBoxAdapter(
                child: CarouselSlider(
                  options: CarouselOptions(height: 150.0),
                  items: bannerImages.map((i) {
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
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 4, right: 8, left: 8),
                      child: InkWell(
                        onTap: () {
                          print(shopListController.shopListResponse["data"][index]["shoptype"]);
                          if (shopListController.shopListResponse["data"][index]["shoptype"] == "1") {
                            print("normal shop");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfileOnlyIndexMain(
                                        selectedShop: shopListController.shopListResponse["data"][index],
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
                          color: Colors.white,
                          child: IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 8, bottom: 8, left: 8),
                                  child: Image.network(
                                    "https://ryz.co.in/admin/upload/" + shopListController.shopListResponse["data"][index]["image"],
                                    width: 100,
                                    height: 100,
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 8),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          shopListController.shopListResponse["data"][index]["shop_name"],
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        Text(
                                          shopListController.shopListResponse["data"][index]["category_name"],
                                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.normal, color: Colors.grey),
                                        ),
                                        Text(
                                          shopListController.shopListResponse["data"][index]["shop_street"],
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: Colors.black),
                                        ),
                                        Text(
                                          "Upto 50% Offers available",
                                          style: TextStyle(
                                            fontSize: 14,
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
                      ),
                    );
                  },
                  childCount: shopListController.shopListResponse["data"].length,
                ),
              ),
            ],
          );
  }
}
