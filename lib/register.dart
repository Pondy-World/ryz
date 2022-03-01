import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ryz/controllers/authcontroller.dart';

class RegisterMainPage extends StatefulWidget {

  @override
  _RegisterMainPageState createState() => _RegisterMainPageState();
}

class _RegisterMainPageState extends State<RegisterMainPage> {

  AuthController authcon = new AuthController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Logo"),
        ),
        body: Center(
            child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Image.asset(
                "images/logo.png",
              ),
            ),
            Card(
              child: Row(
                children: [],
              ),
            ),
            Center(
              child: Text("Create account",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: TextField(
                controller: authcon.regnamecontroller,
                cursorColor: Colors.black,
                keyboardType: TextInputType.text,
                decoration: new InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width: 1),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                  labelText: 'Name',
                  suffixIcon: Icon(
                    Icons.account_circle_outlined,
                    color: Colors.grey,
                  ),
                  labelStyle: new TextStyle(color: Colors.black),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: TextField(
                cursorColor: Colors.black,
                controller: authcon.regemailcontroller,
                keyboardType: TextInputType.emailAddress,
                decoration: new InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width: 1),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                  labelText: 'Email',
                  suffixIcon: Icon(
                    Icons.alternate_email,
                    color: Colors.grey,
                  ),
                  labelStyle: new TextStyle(color: Colors.black),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: TextField(
                controller: authcon.regmobnocontroller,
                cursorColor: Colors.black,
                keyboardType: TextInputType.number,
                decoration: new InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width: 1),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                  labelText: 'Mobile no.',
                  suffixIcon: Icon(
                    Icons.phone_android,
                    color: Colors.grey,
                  ),
                  labelStyle: new TextStyle(color: Colors.black),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: TextField(
                controller: authcon.regpasswordcontroller,
                cursorColor: Colors.black,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                decoration: new InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width: 1),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                  labelText: 'Password',
                  suffixIcon: Icon(
                    Icons.remove_red_eye,
                    color: Colors.grey,
                  ),
                  labelStyle: new TextStyle(color: Colors.black),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: ElevatedButton(
                onPressed: () async {
                  print("Register Pressed");

                  String email =  authcon.regemailcontroller.text;
                  final bool emailisValid = EmailValidator.validate(email);

                  var mobnocount= authcon.regmobnocontroller.text.length;


                  if(authcon.regnamecontroller.text=="" ||
                      authcon.regemailcontroller.text=="" ||
                      authcon.regmobnocontroller.text=="" ||
                      authcon.regpasswordcontroller.text==""){
                    Fluttertoast.showToast(
                        msg: "Please enter all fields",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        fontSize: 16.0
                    );
                  }else if(!emailisValid){
                    Fluttertoast.showToast(
                        msg: "Please enter a valid email",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        fontSize: 16.0
                    );

                  }else if(mobnocount!=10){
                    Fluttertoast.showToast(
                        msg: "Please enter a valid mobile no.",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        fontSize: 16.0
                    );
                  }
                  else{

                    Fluttertoast.showToast(
                        msg: "Please wait",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        fontSize: 16.0
                    );
                    var success= await authcon.registerUser();

                    if(success=="true"){
                      Navigator.pop(context);
                      Fluttertoast.showToast(
                          msg: "Registration success! Please login",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          fontSize: 16.0
                      );
                    }else{

                      Fluttertoast.showToast(
                          msg:  authcon.loginresponse['message'],
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          fontSize: 16.0
                      );
                    }

                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Register",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                print("Login");
                Navigator.pop(context);
              },
              child: Ink(
                child: Center(
                    child: Text(
                  "Already having account? Login here!",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                      fontSize: 17
                  ),
                )),
              ),
            ),
            SizedBox(
              height: 60,
            )
          ],
        )));
  }
}
