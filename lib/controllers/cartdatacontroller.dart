import 'package:ryz/controllers/cartcontroller.dart';

class CartDataController {


  List cartproducts = [];


  Future<String> cartProductRequest() async {

    cartproducts= await CartControllerSelf().viewProduct();

    print("asdfasdf");
    print(cartproducts);
    var statusval="oString();";
    print(cartproducts.length);
    return statusval;

  }


}