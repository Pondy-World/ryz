import 'package:carousel_slider/carousel_slider.dart';
import 'package:ryz/profileonlyshop/poindex.dart';
import 'package:ryz/shops/ShopListcontroller.dart';
import 'package:flutter/material.dart';
import 'package:ryz/productlst.dart';

class ShopList extends StatefulWidget {
  const ShopList({Key? key}) : super(key: key);

  @override
  _ShopListState createState() => _ShopListState();
}

class _ShopListState extends State<ShopList> {

  ShopListController shopcont = new ShopListController();

  fetchData() async {
    print("*****");
    print(shopcont.shoplistresponse);
    await shopcont.fetchAllShops();
    setState(() {

    });
  }

  var bannerimagae= [
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

    return (shopcont.shoplistresponse["data"]==null)?
    Center(child: CircularProgressIndicator(color: Colors.teal,),)
        :

    CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: SizedBox(
            height: 5,
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
                      child: Image.asset(
                          i
                      )
                  );
                },
              );
            }).toList(),
          ),
        ),


        SliverList(
          delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index){
                return Padding(

                  padding: const EdgeInsets.only(
                      top: 4,
                      right: 8,
                      left: 8
                  ),
                  child: InkWell(
                    onTap: (){

                      print(shopcont.shoplistresponse["data"][index]["shoptype"]);
                      if(shopcont.shoplistresponse["data"][index]["shoptype"] == "1"){
                        print("normal shop");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfileOnlyIndexMain(selectedshop: shopcont.shoplistresponse["data"][index],)
                            ),
                        );
                      }else{
                        print("order shop");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductListMain()
                            ),
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
                              padding: const EdgeInsets.only(
                                  top: 8,
                                  bottom: 8,
                                  left: 8
                              ),
                              child: Image.network(
                                "https://ryz.pondyworld.com/admin/upload/"+shopcont.shoplistresponse["data"][index]["image"],
                                width: 100,
                                height: 100,
                              ),
                            ),

                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 8,
                                    left: 8,
                                    right: 8,
                                    bottom: 8
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [

                                        Text(
                                    shopcont.shoplistresponse["data"][index]["shop_name"],
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 20
                                          ),
                                        ),

                                    Text(
                                      shopcont.shoplistresponse["data"][index]["category_name"],
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.grey
                                      ),
                                    ),

                                    Text(
                                      shopcont.shoplistresponse["data"][index]["shop_street"],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black
                                      ),
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
              },  childCount: shopcont.shoplistresponse["data"].length,
          ),
        ),
      ],
    );
  }
}
