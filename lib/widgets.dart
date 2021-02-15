import 'package:flutter/material.dart';
import 'constants.dart';

class DrawerButton extends StatelessWidget {
  DrawerButton({
    Key key,
    @required GlobalKey<ScaffoldState> scaffoldKey,
  })  : _scaffoldKey = scaffoldKey,
        super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _scaffoldKey.currentState.openEndDrawer(),
      child: Container(
        height: 30,
        width: 30,
        color: Colors.white,
        child: Icon(Icons.menu),
      ),
    );
  }
}

class AddWaterButton extends StatelessWidget {
  AddWaterButton({
    this.onTap,
    this.title,
  });
  final Function onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: kButtonColor,
          borderRadius: BorderRadius.circular(10),
        ),
        height: 70,
        width: 70,
        margin: EdgeInsets.all(10),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
