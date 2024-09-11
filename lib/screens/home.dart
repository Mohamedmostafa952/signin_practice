// ignore_for_file: camel_case_types

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sigin_practice/screens/sigin.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          // ignore: prefer_const_constructors
          child: Text("logout"),
          onPressed: (){
            FirebaseAuth.instance.signOut().then((value){
              print("signed out successfully");
              // ignore: prefer_const_constructors
            Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen()));
            });
          },),
      ),
    );
  }
}