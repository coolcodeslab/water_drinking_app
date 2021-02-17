import 'package:flutter/material.dart';
import 'package:water_drinking_app/constants.dart';
import 'package:water_drinking_app/screens/home_screen.dart';
import 'package:water_drinking_app/widgets.dart';

class CupSizeScreen extends StatelessWidget {
  static const id = 'CupSizeScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Text(
              'Drink size',
              style: kH2TextStyle,
            ),
            SizedBox(
              height: 60,
            ),
            SizeCard(
              size: 'Small',
              quantity: '60 ml',
            ),
            SizeCard(
              size: 'Medium',
              quantity: '120 ml',
            ),
            SizeCard(
              size: 'large',
              quantity: '240 ml',
            ),
            ActiveButton(
              title: 'Next',
              onTap: () => Navigator.pushNamed(context, HomeScreen.id),
            ),
          ],
        ),
      ),
    );
  }
}

class SizeCard extends StatelessWidget {
  SizeCard({this.size, this.quantity});

  final String size;
  final String quantity;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 10),
      color: Colors.white,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: 35,
            width: 25,
            color: kAccentColor,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                size,
                style: kH3TextStyle,
              ),
              Text(
                quantity,
                style: kH4TextStyle.copyWith(
                  fontSize: 10,
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
