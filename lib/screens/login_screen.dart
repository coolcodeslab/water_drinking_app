import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:water_drinking_app/constants.dart';
import 'package:water_drinking_app/screens/home_screen.dart';
import 'package:water_drinking_app/screens/signup_screen.dart';
import 'package:water_drinking_app/widgets.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;
  String email;
  String password;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 40,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 60,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Log In',
                    style: kH1TextStyle,
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                TextFieldWidget(
                  hintText: 'email',
                  onChanged: onChangedEmail,
                ),
                TextFieldWidget(
                  hintText: 'password',
                  onChanged: onChangedPassword,
                ),
                SizedBox(
                  height: 60,
                ),
                ActiveButton(
                  title: 'Log In',
                  onTap: onTapLogin,
                ),
                InactiveButton(
                  title: 'Sign up',
                  onTap: onTapSignUp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  onTapLogin() async {
    setState(() {
      showSpinner = true;
    });
    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    } catch (e) {
      print(e);
    }
    setState(() {
      showSpinner = false;
    });
  }

  onTapSignUp() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SingUpScreen()));
  }

  onChangedEmail(n) {
    email = n;
  }

  onChangedPassword(n) {
    password = n;
  }
}
