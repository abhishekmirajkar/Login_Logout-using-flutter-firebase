
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterapploginassignment/login_page.dart';

class homescreen extends StatelessWidget {
  FirebaseUser user;
  homescreen(FirebaseUser this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false,title: Text("Welcome Back}"),),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(),
           Text("Hello User"),
           RaisedButton(onPressed: (){

             Navigator.pop(context);
           }, child: Text("Logout"),)
          ],
        ),
      ),
      );

  }
}
