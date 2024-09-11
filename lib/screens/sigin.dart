// ignore_for_file: camel_case_types, use_super_parameters, deprecated_member_use, sort_child_properties_last

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sigin_practice/hexcolors.dart';
import 'package:sigin_practice/screens/home.dart';
import 'package:sigin_practice/screens/signup.dart';
import 'package:firebase_core/firebase_core.dart';


Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      home: const SignInScreen(),
    );
  }
}

class SignInScreen extends StatefulWidget{
  const SignInScreen ({Key? key}) : super(key : key);
  // const siginScreen ({super.key});

  
  @override
  State<SignInScreen> createState() => _siginState();
  
}

class _siginState extends   State<SignInScreen>{
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: 
          [Hexcolors("CB2B93"),
          Hexcolors("9546C4"),
          Hexcolors("5E61F4")],begin: Alignment.topCenter, end: Alignment.bottomCenter )),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  logowidget("imgs/R.png"),
                  const SizedBox(
                    height: 30,
                  ),
                  textField("Enter Username", Icons.person_outline, false, _emailTextController),
                  const SizedBox(
                    height: 20,
                  ),
                  textField("Enter Password", Icons.lock_outline, true, _passwordTextController),
                    const SizedBox(
                    height: 20,
                  ),
                  buttons(context, true, (){
                    FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: _emailTextController.text, password: _passwordTextController.text).then((value){
                        Navigator.push(context, 
                    MaterialPageRoute(builder: (context) => const homepage()));
                      }).onError((error , StackTrace){
                        print("Error ${error.toString()}");
                      });

                  }),
                  signinOption(),
                ],
              ),
           ),
        ),
      ),
    );
  }

  Image logowidget(String imgName){
    return Image.asset(
      imgName,
      fit: BoxFit.contain,
      width: 250,
      height: 250,
      color: Colors.white,
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
  Row signinOption(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account?",
        style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: (){
            Navigator.push(context, 
            MaterialPageRoute(builder: (context) => const signupScreen()));
          },
          child: const Text(
            " Sign up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}