import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:water_drinking_app/constants.dart';
import 'package:water_drinking_app/screens/home_screen.dart';
import 'package:water_drinking_app/widgets.dart';

class SingUpScreen extends StatefulWidget {
  @override
  _SingUpScreenState createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  final _auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;
  String email;
  String password;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  BackButton(),
                  Text(
                    'Sign up',
                    style: kH1TextStyle,
                  ),
                ],
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
                title: 'Sign up',
                onTap: onTapSignUp,
              ),
            ],
          ),
        ),
      ),
    );
  }

  onTapSignUp() async {
    setState(() {
      showSpinner = true;
    });
    try {
      final user = await _auth.createUserWithEmailAndPassword(
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

  onChangedEmail(n) {
    email = n;
  }

  onChangedPassword(n) {
    password = n;
  }
}
