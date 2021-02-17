import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:water_drinking_app/constants.dart';
import 'package:water_drinking_app/screens/results_screen.dart';
import 'package:water_drinking_app/widgets.dart';

class CalculateScreen extends StatefulWidget {
  static const id = 'CalculateScreen';
  @override
  _CalculateScreenState createState() => _CalculateScreenState();
}

class _CalculateScreenState extends State<CalculateScreen> {
  final _fireStore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  String input;
  String uid;
  String email;

  @override
  void initState() {
    uid = _auth.currentUser.uid;
    email = _auth.currentUser.email;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                SizedBox(
                  height: 60,
                ),
                Text(
                  'Calculate the \namount of water required for you!',
                  style: kH2TextStyle,
                ),
                SizedBox(
                  height: 60,
                ),
                TextFieldWidget(
                  hintText: 'weight in pounds',
                  onChanged: onChangedCalculate,
                ),
                SizedBox(
                  height: 20,
                ),
                ActiveButton(
                  title: 'Calculate',
                  onTap: onTapCalculate,
                ),
              ],
            )),
      ),
    );
  }

  onTapCalculate() {
    final weight = double.parse(input);
    final answer = ((((weight / 2) * 40) / 28.3) * 29.5735).round();
    print(answer);
    _fireStore.collection('users').doc(uid).set({
      'email': email,
      'uid': uid,
      'goal': answer,
    });

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ResultsScreen(
                  amount: answer,
                )));
  }

  onChangedCalculate(n) {
    input = n;
  }
}
