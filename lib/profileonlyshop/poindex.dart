import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProfileOnlyIndexMain extends StatelessWidget {
  final selectedshop;

  const ProfileOnlyIndexMain({Key? key, this.selectedshop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProfileOnlyIndex(selectedshop: selectedshop,);
  }
}

class ProfileOnlyIndex extends StatefulWidget {
  final selectedshop;

  const ProfileOnlyIndex({Key? key, this.selectedshop}) : super(key: key);

  @override
  _ProfileOnlyIndexState createState() => _ProfileOnlyIndexState(selectedshop);
}

class _ProfileOnlyIndexState extends State<ProfileOnlyIndex> {

  final selectedshop;

  _ProfileOnlyIndexState(this.selectedshop);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(selectedshop);
  }

  @override
  Widget build(BuildContext context) {


    var width = MediaQuery.of(context).size.width;


    Widget smallScreen(){
      return Scaffold(
        appBar: AppBar(
          title: Text(selectedshop['shop_name']),
        ),
        body: CustomScrollView(
          slivers: [

            SliverToBoxAdapter(
              child: CarouselSlider(
                options: CarouselOptions(
                    height: 150.0,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 2),
                ),
                items:["https://ryz.pondyworld.com/admin/upload/"+selectedshop['image'],"https://ryz.pondyworld.com/admin/upload/"+selectedshop['image'],].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            // color: Colors.amber
                          ),
                          child: Image.network(
                              i
                          )
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            //
            // SliverToBoxAdapter(
            //   child: Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Container(
            //       height: MediaQuery.of(context).size.height/4,
            //       child: Card(
            //           elevation: 1,
            //           child:
            //           Image.network(
            //             "https://ryz.pondyworld.com/admin/upload/"+selectedshop['image'],
            //             fit: BoxFit.cover,
            //           )
            //       ),
            //     ),
            //   ),
            // ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 4,
                    left: 8,
                    bottom: 8
                ),
                child: Text(
                  selectedshop['category_name'],
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.grey
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 4,
                    left: 8,
                    bottom: 8
                ),
                child: Text(
                  selectedshop['shop_name'],
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500
                  ),
                ),
              ),
            ),


            SliverToBoxAdapter(
              child: Padding(
                  padding: const EdgeInsets.only(
                      top: 0,
                      left: 0,
                      bottom: 0
                  ),
                  child: RatingBar.builder(
                    itemSize: 25,
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 3.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  )
              ),
            ),


            SliverToBoxAdapter(
              child: Padding(
                  padding: const EdgeInsets.only(
                      top: 4,
                      left: 8,
                      bottom: 8,
                      right: 8
                  ),
                  child: Table(
                    // border: TableBorder.all(),

                    columnWidths: const <int, TableColumnWidth>{
                      0: IntrinsicColumnWidth(),
                      1: FlexColumnWidth(),
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: <TableRow>[
                      TableRow(
                        children: <Widget>[
                          Text(
                            "Address:",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.blueGrey
                            ),
                          ),
                          TableCell(
                            verticalAlignment: TableCellVerticalAlignment.top,
                            child: Text(
                              selectedshop['shop_street']+" "+selectedshop['shop_city']+" "+selectedshop['shop_state']+" "+selectedshop['shop_pincode'],
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.blueGrey
                              ),
                            ),
                          ),

                        ],
                      ),


                      TableRow(
                        children: <Widget>[
                          Text(
                            "Status:",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.blueGrey
                            ),
                          ),
                          TableCell(
                            verticalAlignment: TableCellVerticalAlignment.top,
                            child: Text(
                              selectedshop['status'],
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.blueGrey
                              ),
                            ),
                          ),

                        ],
                      ),

                      TableRow(
                        children: <Widget>[
                          Text(
                            "Contact No.: ",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.blueGrey
                            ),
                          ),
                          TableCell(
                            verticalAlignment: TableCellVerticalAlignment.top,
                            child: Text(
                              selectedshop['shop_number'],
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.blueGrey
                              ),
                            ),
                          ),

                        ],
                      ),

                      TableRow(
                        children: <Widget>[
                          Text(
                            "Code:",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.blueGrey
                            ),
                          ),
                          TableCell(
                            verticalAlignment: TableCellVerticalAlignment.top,
                            child: Text(
                              selectedshop['shop_code'],
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.blueGrey
                              ),
                            ),
                          ),

                        ],
                      ),

                      TableRow(
                        children: <Widget>[
                          Text(
                            "GST no.:",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.blueGrey
                            ),
                          ),
                          TableCell(
                            verticalAlignment: TableCellVerticalAlignment.top,
                            child: Text(
                              selectedshop['gst_num'],
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.blueGrey
                              ),
                            ),
                          ),

                        ],
                      ),


                    ],
                  )
              ),
            ),



          ],
        ),
      );
    }

    Widget largeScreen(){

      return Scaffold(
        appBar: AppBar(
          title: Text(
            selectedshop['shop_name'],
          ),
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Container(
                      height: MediaQuery.of(context).size.height/4,
                      child: Card(
                          elevation: 1,
                          child:
                          Image.network(
                            "https://ryz.pondyworld.com/admin/upload/"+selectedshop['image'],
                            fit: BoxFit.cover,
                          )
                      ),
                    ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 4,
                              left: 8,
                              bottom: 8
                          ),
                          child: Text(
                            selectedshop['category_name'],
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.grey
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(
                              top: 4,
                              left: 8,
                              bottom: 8
                          ),
                          child: Text(
                            selectedshop['shop_name'],
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                        ),


                        Padding(
                            padding: const EdgeInsets.only(
                                top: 0,
                                left: 0,
                                bottom: 0
                            ),
                            child: RatingBar.builder(
                              itemSize: 25,
                              initialRating: 3,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding: EdgeInsets.symmetric(horizontal: 3.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            )
                        ),

                        Padding(
                            padding: const EdgeInsets.only(
                                top: 4,
                                left: 8,
                                bottom: 8,
                                right: 8
                            ),
                            child: Table(
                              // border: TableBorder.all(),

                              columnWidths: const <int, TableColumnWidth>{
                                0: IntrinsicColumnWidth(),
                                1: IntrinsicColumnWidth(),
                              },
                              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                              children: <TableRow>[
                                TableRow(
                                  children: <Widget>[
                                    Text(
                                      "Address:",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.blueGrey
                                      ),
                                    ),
                                    TableCell(
                                      verticalAlignment: TableCellVerticalAlignment.top,
                                      child: Text(
                                        selectedshop['shop_street']+" "+selectedshop['shop_city']+" "+selectedshop['shop_state']+" "+selectedshop['shop_pincode'],
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black
                                        ),
                                      ),
                                    ),

                                  ],
                                ),


                                TableRow(
                                  children: <Widget>[
                                    Text(
                                      "Status:",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.blueGrey
                                      ),
                                    ),
                                    TableCell(
                                      verticalAlignment: TableCellVerticalAlignment.top,
                                      child: Text(
                                        selectedshop['status'],
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black
                                        ),
                                      ),
                                    ),

                                  ],
                                ),

                                TableRow(
                                  children: <Widget>[
                                    Text(
                                      "Contact No.: ",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.blueGrey
                                      ),
                                    ),
                                    TableCell(
                                      verticalAlignment: TableCellVerticalAlignment.top,
                                      child: Text(
                                        selectedshop['shop_number'],
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black
                                        ),
                                      ),
                                    ),

                                  ],
                                ),

                                TableRow(
                                  children: <Widget>[
                                    Text(
                                      "Code:",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.blueGrey
                                      ),
                                    ),
                                    TableCell(
                                      verticalAlignment: TableCellVerticalAlignment.top,
                                      child: Text(
                                        selectedshop['shop_code'],
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black
                                        ),
                                      ),
                                    ),

                                  ],
                                ),

                                TableRow(
                                  children: <Widget>[
                                    Text(
                                      "GST no.:",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.blueGrey
                                      ),
                                    ),
                                    TableCell(
                                      verticalAlignment: TableCellVerticalAlignment.top,
                                      child: Text(
                                        selectedshop['gst_num'],
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black
                                        ),
                                      ),
                                    ),

                                  ],
                                ),


                              ],
                            )
                        ),


                      ],
                    )

                  ],
                ),
              ),
            ),

          ],
        ),
      );
    }

    return (width<800)?
    smallScreen()
        :
    largeScreen();



  }
}
