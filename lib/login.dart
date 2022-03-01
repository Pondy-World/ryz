import 'package:localstorage/localstorage.dart';
import 'package:ryz/AppState.dart';
import 'package:ryz/main.dart';
import 'package:flutter/material.dart';
import 'package:ryz/controllers/authcontroller.dart';

import 'package:ryz/register.dart';
import 'package:fluttertoast/fluttertoast.dart';


class LoginMain extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LoginMainPage(title: "RYZ");
  }
}

class LoginMainPage extends StatefulWidget {
  LoginMainPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _LoginMainPageState createState() => _LoginMainPageState();
}

class _LoginMainPageState extends State<LoginMainPage> {
  AuthController authcon = new AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
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
              child: Text("Sign into your account",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: TextField(
                controller: authcon.usernamecontroller,
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
                  labelText: 'Email / Mobile no.',
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
                controller: authcon.passwordcontroller,
                obscureText: true,
                cursorColor: Colors.black,
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
                  print("Login Pressed");

                  if(authcon.usernamecontroller.text=="" || authcon.passwordcontroller.text==""){
                    Fluttertoast.showToast(
                        msg: "Please enter both fields",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        fontSize: 16.0
                    );
                  }else{

                    Fluttertoast.showToast(
                        msg: "Please wait",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        fontSize: 16.0
                    );
                    var success= await authcon.loginUser();

                    if(success=="true"){

                      RyzAppState().isLogin = true;

                      Navigator.pop(context);

                      Fluttertoast.showToast(
                          msg: "Happy Shopping!",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          fontSize: 16.0
                      );

                      Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));

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
                    "Login",
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
                print("Register");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RegisterMainPage()));
              },
              child: Ink(
                child: Center(
                    child: Text(
                  "New user? Register here!",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 17
                  ),
                )),
              ),
            ),

            SizedBox(
              height: 20,
            )

          ],
        )));
  }
}
