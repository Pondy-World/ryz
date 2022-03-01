import 'package:flutter/material.dart';
import 'package:ryz/AppState.dart';
import 'package:ryz/login.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({Key? key}) : super(key: key);

  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
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
                child: Text("Profile",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: TextField(
                  readOnly: true,
                  controller: TextEditingController(text: RyzAppState().name),
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
                  readOnly: true,
                  cursorColor: Colors.black,
                  controller: TextEditingController(text: RyzAppState().email),
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
                  readOnly: true,
                  controller: TextEditingController(text: RyzAppState().phone),
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
                child: ElevatedButton(
                  onPressed: () async {
                    print('Logout');
                    RyzAppState().isLogin = false;
                    RyzAppState().name = '';
                    RyzAppState().email = '';
                    RyzAppState().phone = '';
                    RyzAppState().id = '';
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginMain()), (route) => false);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Log Out",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          )));
  }
}
