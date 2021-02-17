import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:water_drinking_app/constants.dart';
import 'package:water_drinking_app/screens/login_screen.dart';
import 'package:water_drinking_app/widgets.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _fireStore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  final DateTime todayDateTime = DateTime.now();
  int goal;
  int waterLeft;
  int dailyGoal;
  double startingValue;
  bool loading = false;
  String date;

  @override
  void initState() {
    date = DateFormat('yMMMd').format(todayDateTime);
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: _scaffoldKey,
        endDrawer: Container(
          width: 150,
          color: kBackgroundColor,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              FlatButton(
                onPressed: onPressedLogOut,
                child: Text(
                  'log out',
                  style: kH2TextStyle,
                ),
              )
            ],
          ),
        ),
        backgroundColor: kBackgroundColor,
        body: loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                    width: double.infinity,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              date,
                              style: kH4TextStyle,
                            ),
                            Text(
                              'Daily goal $goal',
                              style: kH2TextStyle,
                            ),
                          ],
                        ),
                        DrawerButton(
                          scaffoldKey: _scaffoldKey,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: CircularPercentIndicator(
                      radius: 216,
                      lineWidth: 20,
                      animation: true,
                      animateFromLastPercent: true,
                      percent: startingValue,
                      center: new Text(
                        "${waterLeft}ml \nmore",
                        textAlign: TextAlign.center,
                        style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: kAccentColor,
                      backgroundColor: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AddWaterButton(
                        onTap: onPressedSmall,
                        title: 'Small',
                      ),
                      AddWaterButton(
                        onTap: onPressedMedium,
                        title: 'Medium',
                      ),
                      AddWaterButton(
                        onTap: onPressedLarge,
                        title: 'Large',
                      ),
                    ],
                  )
                ],
              ),
      ),
    );
  }

  onPressedLogOut() {
    _auth.signOut();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  getData() async {
    setState(() {
      loading = true;
    });

    ///checking if the document exists
    await _fireStore
        .collection('users')
        .doc('4zsYjkndqf2kjPTaVHyW')
        .collection('data')
        .doc(date)
        .get()
        .then((value) async {
      if (value.exists) {
        ///setting data
        await _fireStore
            .collection('users')
            .doc('4zsYjkndqf2kjPTaVHyW')
            .collection('data')
            .doc(date)
            .get()
            .then((value) {
          goal = value['goal'];
          waterLeft = value['goal'];
          startingValue = value['value'] == 0 ? 0.0 : value['value'];
        });
      } else {
        ///setting data
        await _fireStore
            .collection('users')
            .doc('4zsYjkndqf2kjPTaVHyW')
            .collection('data')
            .doc(date)
            .set({
          'value': 0,
          'goal': 2200,
        });

        ///setting the first data
        await _fireStore
            .collection('users')
            .doc('4zsYjkndqf2kjPTaVHyW')
            .collection('data')
            .doc(date)
            .get()
            .then((value) {
          goal = value['goal'];
          waterLeft = value['goal'];
          startingValue = value['value'] == 0 ? 0.0 : value['value'];
        });
      }
    });

    setState(() {
      loading = false;
    });
  }

  updateValue() {
    _fireStore
        .collection('users')
        .doc('4zsYjkndqf2kjPTaVHyW')
        .collection('data')
        .doc(date)
        .update({
      'value': startingValue,
      'goal': waterLeft,
    });
  }

  onPressedSmall() {
    if (waterLeft > 60) {
      double newVal = (1.0 / goal) * 60;

      setState(() {
        startingValue += newVal;
      });

      ///decrease from goal
      waterLeft -= 60;
    } else if (startingValue != 1.0) {
      final finalValue = 1.0 - startingValue;
      setState(() {
        startingValue += finalValue;
        waterLeft = 0;
      });
    }
    updateValue();
  }

  onPressedMedium() {
    if (waterLeft > 120) {
      double newVal = (1.0 / goal) * 120;

      setState(() {
        startingValue += newVal;
      });

      ///decrease from goal
      waterLeft -= 120;
    } else if (startingValue != 1.0) {
      final finalValue = 1.0 - startingValue;
      setState(() {
        startingValue += finalValue;
        waterLeft = 0;
      });
    }
    updateValue();
  }

  onPressedLarge() {
    if (waterLeft > 240) {
      double newVal = (1.0 / goal) * 240;

      setState(() {
        startingValue += newVal;
      });

      ///decrease from goal
      waterLeft -= 240;
    } else if (startingValue != 1.0) {
      final finalValue = 1.0 - startingValue;
      setState(() {
        startingValue += finalValue;
        waterLeft = 0;
      });
    }
    updateValue();
  }
}
