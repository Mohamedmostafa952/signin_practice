// ignore_for_file: camel_case_types, sort_child_properties_last, deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sigin_practice/hexcolors.dart';
import 'package:sigin_practice/screens/home.dart';
// import 'package:sigin_practice/screens/signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign In Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const signupScreen(),
    );
  }
}


class signupScreen extends StatefulWidget {
  const signupScreen({super.key});

  @override
  State<signupScreen> createState() => _signupScreenState();
}

class _signupScreenState extends State<signupScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _usernameTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        // elevation: 0,
        title: const Text(
          "Sign up",
          style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: 
          [Hexcolors("CB2B93"),
          Hexcolors("9546C4"),
          Hexcolors("5E61F4")],
          begin: Alignment.topCenter, end: Alignment.bottomCenter )),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 30,
                  ),
                  textField("Enter Username", Icons.person_outline, false, _usernameTextController),
                  const SizedBox(
                    height: 20,
                  ),
                  textField("Enter Email", Icons.lock_outline, false, _emailTextController),
                    const SizedBox(
                    height: 20,
                  ),
                  textField("Enter Password", Icons.lock_outline, true, _passwordTextController),
                  const SizedBox(
                    height: 20,
                  ),
                  buttons(context, false, (){
                    FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: _emailTextController.text, password: _passwordTextController.text).then((value){
                        print("Created new account");
                        Navigator.push(context, 
                    MaterialPageRoute(builder: (context) => const homepage()));
                      }).onError((error , StackTrace){
                        print("Error ${error.toString()}");
                      });

                  }),
                ],
              ),
           ),
        ),
      ),
    );
  }


  TextField textField(String text, IconData icon , bool ispasswordtype, TextEditingController controller){
    return TextField(
      autocorrect: !ispasswordtype,
      controller: controller,
      obscureText: ispasswordtype,
      enableSuggestions: !ispasswordtype,
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white.withOpacity(0.9)),
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: Colors.white70
        ),
      labelText: text,
      labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.white.withOpacity(0.3),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(width: 0, style: BorderStyle.none)),  
      ),
      keyboardType: ispasswordtype
      ? TextInputType.visiblePassword
      : TextInputType.emailAddress,
      );
  }
  Container buttons(BuildContext context, bool islogin, Function onTap){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
      child: ElevatedButton(onPressed: (){
        onTap();
      }, child: Text(
        islogin ? 'LOG IN': 'SIGN UP',
        style: const TextStyle(
          color: Colors.black87, fontWeight: FontWeight.bold,fontSize: 16
          ),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states){
          if(states.contains(MaterialState.pressed)){
            return Colors.black26;
          }
          return Colors.white;
        }),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
    ),
  );
  }
}