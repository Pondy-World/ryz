class PdsList{

  final String name;
  final String email;

  PdsList(this.name, this.email);

  PdsList.fromJson(Map<String, dynamic> json): name = json['name'], email = json['email'];


  Map<String, dynamic> toJson() => {
  'name': name,
  'email': email,
  };


  // String name;
  // String image;
  // String price;
  // String quantity;
  // String offrprice;
  // String catagory;
  //
  // PdsList(this.name, this.catagory, this.image, this.offrprice, this.price, this.quantity);
  //


  //
  // var productslists=
  //   [
  //     {
  //       "name": "Ponlait milk",
  //       "image": "images/pds/1.jpg",
  //       "price": "12",
  //       "quantity": "200kg",
  //       "offrprice": "10",
  //       "catagory": "2",
  //     },
  //     {
  //       "name": "Tomato",
  //       "image": "images/pds/2.jpg",
  //       "price": "12",
  //       "quantity": "200kg",
  //       "offrprice": "10",
  //       "catagory": "2",
  //     },
  //     {
  //       "name": "Potato",
  //       "image": "images/pds/3.jpg",
  //       "price": "12",
  //       "quantity": "200kg",
  //       "offrprice": "10",
  //       "catagory": "2",
  //     },
  //     {
  //       "name": "Ashridwad Wheat",
  //       "image": "images/pds/4.jpg",
  //       "price": "12",
  //       "quantity": "200kg",
  //       "offrprice": "10",
  //       "catagory": "2",
  //     },
  //     {
  //       "name": "Onion",
  //       "image": "images/pds/5.jpg",
  //       "price": "12",
  //       "quantity": "200kg",
  //       "offrprice": "10",
  //       "catagory": "2",
  //     },
  //     {
  //       "name": "Small onion",
  //       "image": "images/pds/6.jpg",
  //       "price": "12",
  //       "quantity": "200kg",
  //       "offrprice": "10",
  //       "catagory": "2",
  //     },
  //     {
  //       "name": "Orange",
  //       "image": "images/pds/7.jpg",
  //       "price": "12",
  //       "quantity": "200kg",
  //       "offrprice": "10",
  //       "catagory": "2",
  //     },
  //     {
  //       "name": "Apple",
  //       "image": "images/pds/8.jpg",
  //       "price": "12",
  //       "quantity": "200kg",
  //       "offrprice": "10",
  //       "catagory": "2",
  //     },
  //     {
  //       "name": "Spinach",
  //       "image": "images/pds/9.jpg",
  //       "price": "12",
  //       "quantity": "200kg",
  //       "offrprice": "10",
  //       "catagory": "2",
  //     },
  //
  //     {
  //       "name": "Milk bikies",
  //       "image": "images/pds/10.jpg",
  //       "price": "12",
  //       "quantity": "200kg",
  //       "offrprice": "10",
  //       "catagory": "2",
  //     },
  //     {
  //       "name": "Dairy milk",
  //       "image": "images/pds/11.jpg",
  //       "price": "12",
  //       "quantity": "200kg",
  //       "offrprice": "10",
  //       "catagory": "2",
  //     },
  //     {
  //       "name": "Salt",
  //       "image": "images/pds/12.jpg",
  //       "price": "12",
  //       "quantity": "200kg",
  //       "offrprice": "10",
  //       "catagory": "2",
  //     },
  //
  //   ];
}