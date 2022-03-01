import 'package:flutter/material.dart';
import 'package:ryz/productlst.dart';
import 'package:ryz/profileonlyshop/poindex.dart';
import 'package:ryz/shops/ShopListcontroller.dart';

class ShopListCat extends StatefulWidget {
  final String headingVal;
  final String headId;
  final String bannerUrl;

  //
  // const ShopListCat({Key? key}) : super(key: key);

  ShopListCat(this.headingVal, this.headId, this.bannerUrl);

  @override
  _ShopListcatState createState() => _ShopListcatState(headingVal, headId);
}

class _ShopListcatState extends State<ShopListCat> {
  _ShopListcatState(this.headingval, this.headid);

  final String headingval;
  final String headid;

  ShopListController shopcont = new ShopListController();

  fetchData() async {
    print("*****");
    print(shopcont.shoplistresponse);
    await shopcont.fetchShopsCat(headid);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: new PreferredSize(
          child: new Container(
            color: Colors.blue,
            padding: new EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Padding(
              // padding: const EdgeInsets.only(
              //     left: 30.0,
              //     top: 20.0,
              //     bottom: 20.0
              // ),
              padding: const EdgeInsets.all(0),

              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      print("BACK pressed");
                      Navigator.of(context).pop();
                    },
                  ),
                  Text(
                    headingval,
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20, fontFamily: "Lato", letterSpacing: .5),
                  ),
                ],
              ),
            ),
          ),
          preferredSize: new Size(
            MediaQuery.of(context).size.width,
            MediaQuery.of(context).padding.top + 55,
          ),
        ),
        body: (shopcont.shoplistresponse["data"] == null)
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
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 4, right: 8, left: 8),
                          child: InkWell(
                            onTap: () {
                              print(shopcont.shoplistresponse["data"][index]["shoptype"]);
                              if (shopcont.shoplistresponse["data"][index]["shoptype"] == "1") {
                                print("normal shop");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProfileOnlyIndexMain(
                                            selectedshop: shopcont.shoplistresponse["data"][index],
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
                                        "https://ryz.pondyworld.com/admin/upload/"+shopcont.shoplistresponse["data"][index]["image"],
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
                                              shopcont.shoplistresponse["data"][index]["shop_name"],
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(fontFamily: 'Lato', fontSize: 20, fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              shopcont.shoplistresponse["data"][index]["category_name"],
                                              style: TextStyle(fontSize: 17, fontWeight: FontWeight.normal, color: Colors.grey),
                                            ),
                                            Text(
                                              shopcont.shoplistresponse["data"][index]["shop_street"],
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
                          ),
                        );
                      },
                      childCount: shopcont.shoplistresponse["data"].length,
                    ),
                  ),
                ],
              ));
  }
}
