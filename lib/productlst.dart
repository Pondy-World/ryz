import 'package:carousel_slider/carousel_slider.dart';
import 'package:ryz/controllers/cartcontroller.dart';
import 'package:ryz/controllers/cartdatacontroller.dart';
import 'package:ryz/controllers/productcontroller.dart';
import 'package:flutter/material.dart';


class ProductListMain extends StatelessWidget {
  const ProductListMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProductList();
  }
}

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {

  var name= [
     "Breakfast & Dairy",
    "Fresh vegs",
    "Fresh Fruits",
    "Snacks & Beverages",
    "Provisions",
    "Instant foods",
    "Cleaning & Households",
    "Pet Foods",
    "Baby Care",
    "Chocolates",
    "Meat",
    "Fish",
    "Ice Creams"
  ];

  var selectedcat="";


  ProductController prodcont = new ProductController();
  CartDataController procartobj = new CartDataController();
  CartControllerSelf slfcart= new CartControllerSelf();

  var cartids=[];

  fetchData() async {
    print("*****");
    print(prodcont.productlist);
    await prodcont.fetchproducts();
    setState(() {

    });
  }

  getCartData() async {
    cartids = [];
    await procartobj.cartProductRequest();

    for (var cartpds in  procartobj.cartproducts) {
      print(cartpds['id']);
      cartids.add(cartpds['id']);
    }

    setState(() {

    });
  }

  int getpdcount(id){
    var result=0;
    print("*****");
    print(id);
    print("*******");
    for (var cartpds in  procartobj.cartproducts) {
      if(id.toString()==cartpds['id'])
        result= cartpds['count'];
    }
    return result;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedcat = name[0];
    getCartData();
    fetchData();
  }

  var bannerimagae= [
    "images/veg.jpg",
    "images/veg.jpg",
    "images/veg.jpg",
  ];

  @override
  Widget build(BuildContext context) {

    var width= MediaQuery.of(context).size.width;

    Widget smallScreen(){
      return Scaffold(
          appBar: new PreferredSize(
            child: new Container(
              color:  Colors.blue,
              padding: new EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top
              ),
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
                      "Groceries",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: "Lato",
                          letterSpacing:.5
                      ),
                    ),

                  ],
                ),
              ),


            ),
            preferredSize: new Size(
              MediaQuery.of(context).size.width,
              MediaQuery.of(context).padding.top+55,
            ),
          ),
          body: (prodcont.productlist.isEmpty)?
          Center(
            child: CircularProgressIndicator(

            ),
          ):
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 5,
                ),
              ),


              SliverToBoxAdapter(
                child: Container(
                  height: 50.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 13,
                    itemBuilder: (context, index) {
                      return Container(
                        child: Center(
                          child: InkWell(
                            onTap: (){
                              selectedcat=name[index];
                              setState(() {

                              });
                            },
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "images/gros.png",
                                      width: 39,
                                      height: 39,
                                    ),
                                    Text(
                                      name[index],
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
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

              SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      selectedcat,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
              ),

              SliverList(
                delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index){
                      var prodsall= prodcont.productlist[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IntrinsicHeight(
                          child: Row(

                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,

                            children: [

                              Image.network(
                                prodsall['product_image'],
                                width: 100,
                                height: 100,
                              ),

                              Expanded(
                                child: Container(

                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5,
                                        right: 5,
                                        top: 10,
                                        bottom: 10
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            prodsall['title'],
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 17.0,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),
                                        Text('₹ '+prodsall['price']),
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


                                    Padding(
                                      padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5.0 ,top: 5),
                                      child:
                                      (cartids.contains(prodsall['id'].toString()))?
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              print("Minus one");

                                              var count= getpdcount(prodsall['id']);

                                              if(count==1){
                                                // await CartController().deleteCrtProduct(prodsall['id'].toString());

                                                await CartControllerSelf().deleteProduct(prodsall['id'].toString());

                                                await getCartData();
                                              }else{
                                                count = count-1;

                                                var pdvproduct=CrtPds2(
                                                    id: prodsall['id'].toString(),
                                                    name: prodsall['title'].toString(),

                                                    amount:  prodsall['price'].toString(),
                                                    count:  count,
                                                    imgurlval:  prodsall['product_image'],

                                                    price:  prodsall['price'].toString(),
                                                    offer:  "false",
                                                    offerprice:  prodsall['offer_price'].toString(),
                                                    weight: "2"
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
                                            padding: const EdgeInsets.only(right: 5, left: 5),
                                            child: Text(
                                              getpdcount(prodsall['id']).toString(),
                                              style: TextStyle(
                                                  fontSize: 20,

                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  backgroundColor: Colors.white
                                              ),
                                            ),
                                          ),

                                          InkWell(
                                            onTap: () async {

                                              print("Plus one");

                                              var count= getpdcount(prodsall['id']);
                                              count = count+1;

                                              var pdvproduct=CrtPds2(
                                                  id: prodsall['id'].toString(),
                                                  name: prodsall['title'].toString(),

                                                  amount:  prodsall['price'].toString(),
                                                  count:  count,
                                                  imgurlval:  prodsall['product_image'],

                                                  price:  prodsall['price'].toString(),
                                                  offer:  "false",
                                                  offerprice:  prodsall['offer_price'].toString(),
                                                  weight: "2"
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
                                      )
                                          :
                                      ElevatedButton(
                                        onPressed: () async {
                                          print("Add to cart");
                                          var pdvproduct=CrtPds2(
                                              id: prodsall['id'].toString(),
                                              name: prodsall['title'].toString(),

                                              amount:  prodsall['price'].toString(),
                                              count:  1,
                                              imgurlval:  prodsall['product_image'],

                                              price:  prodsall['price'].toString(),
                                              offer:  "false",
                                              offerprice:  prodsall['offer_price'].toString(),
                                              weight: "2"
                                          );

                                          await CartControllerSelf().insertProduct(pdvproduct);
                                          await getCartData();

                                        },
                                        child: Text("Add"),
                                        style: ElevatedButton.styleFrom(
                                            primary:  Colors.blue,

                                            textStyle: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold)
                                        ),
                                      ),
                                    )




                                    // ElevatedButton(
                                    //   onPressed: (){
                                    //
                                    //   },
                                    //   child: Text("Add"),
                                    //   style: ElevatedButton.styleFrom(
                                    //       primary:  Colors.blue,
                                    //
                                    //       textStyle: TextStyle(
                                    //           fontSize: 17,
                                    //           fontWeight: FontWeight.bold)),
                                    // ),

                                  ],
                                ),
                              )


                            ],
                          ),
                        ),
                      );
                    },childCount: prodcont.productlist.length
                ),
              ),
            ],
          )


      );
    }

    Widget largeScreen(){
        return  Scaffold(
          appBar: new PreferredSize(
            child: new Container(
              color:  Colors.blue,
              padding: new EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top
              ),
              child: Padding(

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
                      "Groceries",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: "Lato",
                          letterSpacing:.5
                      ),
                    ),

                  ],
                ),
              ),


            ),
            preferredSize: new Size(
              MediaQuery.of(context).size.width,
              MediaQuery.of(context).padding.top+55,
            ),
          ),
          body: (prodcont.productlist.isEmpty)?
          Center(
            child: CircularProgressIndicator(

            ),
          ):
          Padding(
            padding: const EdgeInsets.only(
              left: 30,
              right: 30
            ),
            child: CustomScrollView(
              slivers: [


                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                    child: Container(
                      height: MediaQuery.of(context).size.height/4,
                      child: Image.asset(
                        'images/phot.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),


                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 5,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    height: 50.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 13,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Center(
                            child: InkWell(
                              onTap: (){
                                selectedcat=name[index];
                                setState(() {

                                });
                              },
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "images/gros.png",
                                        width: 39,
                                        height: 39,
                                      ),
                                      Text(
                                        name[index],
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        selectedcat,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                ),


                SliverGrid(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 300.0,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    childAspectRatio: 1.0,
                  ),
                  delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          var prodsall= prodcont.productlist[index];
                      return  Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: InkWell(

                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                              ),

                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    prodsall['product_image'],
                                    width: 100,
                                    height: 100,
                                  ),

                                  Text(
                                    prodsall['title'],
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontFamily: "Lato"
                                    ),
                                  ),

                                  Text(
                                      '₹ '+prodsall['price'],
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.black45,
                                        fontFamily: "Lato"
                                    ),
                                  ),


                                  Container(

                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,

                                      children: [


                                        Padding(
                                          padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5.0 ,top: 5),
                                          child:
                                          (cartids.contains(prodsall['id'].toString()))?
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              InkWell(
                                                onTap: () async {
                                                  print("Minus one");

                                                  var count= getpdcount(prodsall['id']);

                                                  if(count==1){
                                                    // await CartController().deleteCrtProduct(prodsall['id'].toString());

                                                    await CartControllerSelf().deleteProduct(prodsall['id'].toString());

                                                    await getCartData();
                                                  }else{
                                                    count = count-1;

                                                    var pdvproduct=CrtPds2(
                                                        id: prodsall['id'].toString(),
                                                        name: prodsall['title'].toString(),

                                                        amount:  prodsall['price'].toString(),
                                                        count:  count,
                                                        imgurlval:  prodsall['product_image'],

                                                        price:  prodsall['price'].toString(),
                                                        offer:  "false",
                                                        offerprice:  prodsall['offer_price'].toString(),
                                                        weight: "2"
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
                                                padding: const EdgeInsets.only(right: 5, left: 5),
                                                child: Text(
                                                  getpdcount(prodsall['id']).toString(),
                                                  style: TextStyle(
                                                      fontSize: 20,

                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black,
                                                      backgroundColor: Colors.white
                                                  ),
                                                ),
                                              ),

                                              InkWell(
                                                onTap: () async {

                                                  print("Plus one");

                                                  var count= getpdcount(prodsall['id']);
                                                  count = count+1;

                                                  var pdvproduct=CrtPds2(
                                                      id: prodsall['id'].toString(),
                                                      name: prodsall['title'].toString(),

                                                      amount:  prodsall['price'].toString(),
                                                      count:  count,
                                                      imgurlval:  prodsall['product_image'],

                                                      price:  prodsall['price'].toString(),
                                                      offer:  "false",
                                                      offerprice:  prodsall['offer_price'].toString(),
                                                      weight: "2"
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
                                          )
                                              :
                                          ElevatedButton(
                                            onPressed: () async {
                                              print("Add to cart");
                                              var pdvproduct=CrtPds2(
                                                  id: prodsall['id'].toString(),
                                                  name: prodsall['title'].toString(),

                                                  amount:  prodsall['price'].toString(),
                                                  count:  1,
                                                  imgurlval:  prodsall['product_image'],

                                                  price:  prodsall['price'].toString(),
                                                  offer:  "false",
                                                  offerprice:  prodsall['offer_price'].toString(),
                                                  weight: "2"
                                              );

                                              await CartControllerSelf().insertProduct(pdvproduct);
                                              await getCartData();

                                            },
                                            child: Text("Add"),
                                            style: ElevatedButton.styleFrom(
                                                primary:  Colors.blue,

                                                textStyle: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold)
                                            ),
                                          ),
                                        )


                                      ],
                                    ),
                                  )

                                ],
                              )
                          ),
                        ),
                      );
                    },
                    childCount: prodcont.productlist.length
                  ),
                ),


              ],
            ),
          )


      );
    }

    return (width<800)?
    smallScreen()
        :
    largeScreen();



  }
}
