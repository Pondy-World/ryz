import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart' hide Location;
import 'package:localstorage/localstorage.dart';
import 'package:location/location.dart' hide PermissionStatus;
import 'package:ryz/AppState.dart';
import 'package:ryz/controllers/addressController.dart';

class AddAddressMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AddAddressPage();
  }
}

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddressPage> {
  AddressController addressController = new AddressController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color(0xfff2efee),
      content: SingleChildScrollView(
        child: Container(
            // height: MediaQuery.of(context).size.height,
            // height: 400,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 900,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8, left: 13),
                    child: Text("Door no.", textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 3),
                  child: Container(
                    height: 45,
                    child: TextField(
                      controller: addressController.doorNo,
                      decoration: InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(),
                        fillColor: Colors.white,
                        hintText: 'Door no',
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 900,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8, left: 13),
                    child: Text("Address", textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 3),
                  child: Container(
                    height: 45,
                    child: TextField(
                      controller: addressController.addressA,
                      decoration: InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(),
                        fillColor: Colors.white,
                        hintText: 'Street name',
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 900,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8, left: 13),
                    child: Text("Address", textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 3),
                  child: Container(
                    height: 45,
                    child: TextField(
                      controller: addressController.addressB,
                      decoration: InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(),
                        fillColor: Colors.white,
                        hintText: 'Locality',
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 900,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8, left: 13),
                    child: Text("Landmark", textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 3),
                  child: Container(
                    height: 45,
                    child: TextField(
                      controller: addressController.landmark,
                      decoration: InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(),
                        fillColor: Colors.white,
                        hintText: 'Landmark',
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 900,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8, left: 13),
                    child: Text("City", textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 3),
                  child: Container(
                    height: 45,
                    child: TextField(
                      controller: addressController.city,
                      decoration: InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(),
                        fillColor: Colors.white,
                        hintText: 'Land mark',
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 900,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8, left: 13),
                    child: Text("Pincode", textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 3),
                  child: Container(
                    height: 45,
                    child: TextField(
                      controller: addressController.pincode,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(),
                        fillColor: Colors.white,
                        hintText: 'Pincode',
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 0, left: 20, right: 20),
                  child: InkWell(
                    onTap: () async {
                      print("add address Pressed");

                      if (addressController.doorNo.text == "" ||
                          addressController.addressA.text == "" ||
                          addressController.addressB.text == "" ||
                          addressController.landmark.text == "" ||
                          addressController.city.text == "" ||
                          addressController.pincode.text == "") {
                        Fluttertoast.showToast(
                            msg: "Please enter all fields",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            fontSize: 16.0);
                      } else {
                        Fluttertoast.showToast(
                            msg: "Please wait", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER, timeInSecForIosWeb: 1, fontSize: 16.0);

                        var success = await addressController.addAddress();

                        if (success == "true") {
                          final LocalStorage storage = new LocalStorage('ryxstorage');

                          var addresssdatas = {
                            'customerid': "10",
                            'doorno': addressController.doorNo.text,
                            'addressa': addressController.addressA.text,
                            'addressb': addressController.addressB.text,
                            'landmark': addressController.landmark.text,
                            'city': addressController.city.text,
                            'pincode': addressController.pincode.text
                          };
                          await storage.setItem("addressdetails", addresssdatas);

                          Navigator.pop(context, addresssdatas);

                          Fluttertoast.showToast(
                              msg: "Added Successfully",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              fontSize: 16.0);
                        } else {
                          return;
                        }
                      }
                    },
                    child: Center(
                      child: Ink(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.blue,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 5,
                            bottom: 5,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Save Address",
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 40, left: 20, right: 20),
                  child: InkWell(
                    onTap: () async {
                      print("detect address Pressed");
                      Fluttertoast.showToast(
                          msg: "Please wait", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER, timeInSecForIosWeb: 1, fontSize: 16.0);

                      final LocalStorage storage = new LocalStorage('ryxstorage');
                      var addressData;

                      Location().getLocation().then((_pos) {
                        placemarkFromCoordinates(_pos.latitude!, _pos.longitude!).then((value) async {
                          addressData = {
                            'customerid': RyzAppState().id,
                            'doorno': value.first.name ?? '',
                            'addressa': value.first.street ?? '',
                            'addressb': value.first.subAdministrativeArea ?? '',
                            'landmark': value.first.administrativeArea ?? '',
                            'city': value.first.country ?? '',
                            'pincode': value.first.postalCode ?? ''
                          };
                          await storage.setItem("addressdetails", addressData);

                          Navigator.pop(context, addressData);

                          Fluttertoast.showToast(
                              msg: "Added Successfully",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              fontSize: 16.0);
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(SnackBar(content: Text(value.first.street!)));
                        });
                      });
                    },
                    child: Center(
                      child: Ink(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.blue,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 5,
                            bottom: 5,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Detect Address",
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
