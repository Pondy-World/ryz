import 'package:ryz/controllers/cartController.dart';

class CartDataController {


  List cartProducts = [];


  Future<String> cartProductRequest() async {

    cartProducts= CartControllerSelf().viewProduct();

    print("asdfasdf");
    print(cartProducts);
    var statusval="oString();";
    print(cartProducts.length);
    return statusval;

  }


}