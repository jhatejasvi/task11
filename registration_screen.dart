import 'package:chat_app/constants.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
class RegistrationScreen extends StatefulWidget {
  static String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool showSpinner=false;
  final _auth = FirebaseAuth.instance;
  String email='Enter your email';
  String password='Enter your password';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      height: 200.0,
                      child: Image.asset('images/logo.png'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blueAccent),
                  onChanged: (value) {
                    //Do something with the user input.
                    email = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your Email')
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.teal),
                  onChanged: (value) {
                    //Do something with the user input.
                    password = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your password')
                ),
                SizedBox(
                  height: 24.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Material(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    elevation: 5.0,
                    child: MaterialButton(
                      onPressed: () async {
                        //Implement registration functionality.
                        // print(email);
                        // print(password);
                        setState(() {
                          showSpinner=true;
                        });
                        try{
                          _auth.signOut();
                        final newUser = _auth.createUserWithEmailAndPassword(email: email, password: password);
                        if (newUser != null){
                          final user = await _auth.signInWithEmailAndPassword(email: email, password: password);
                          setState(() {
                            showSpinner=false;
                          });
                          Navigator.pushNamed(context, ChatScreen.id);
                        }

                        }
                        catch(e) {
                          print(e);
                        }
                      },
                      minWidth: 200.0,
                      height: 42.0,
                      child: Text(
                        'Register',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
