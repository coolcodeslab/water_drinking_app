import 'package:flutter/material.dart';
import 'package:water_drinking_app/constants.dart';
import 'package:water_drinking_app/screens/cupsize_screen.dart';
import 'package:water_drinking_app/widgets.dart';

class ResultsScreen extends StatelessWidget {
  ResultsScreen({this.amount});
  final int amount;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 60,
            ),
            Text(
              'You should drink ${amount}ml of water per day',
              textAlign: TextAlign.center,
              style: kH2TextStyle,
            ),
            ActiveButton(
              title: 'next',
              onTap: () => Navigator.pushNamed(context, CupSizeScreen.id),
            ),
          ],
        ),
      ),
    );
  }
}
