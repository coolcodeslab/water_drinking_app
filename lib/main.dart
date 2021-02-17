import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:water_drinking_app/screens/calculate_screen.dart';
import 'package:water_drinking_app/screens/cupsize_screen.dart';
import 'package:water_drinking_app/screens/home_screen.dart';
import 'package:water_drinking_app/screens/loading_screen.dart';
import 'package:water_drinking_app/screens/login_screen.dart';
import 'package:water_drinking_app/screens/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: LoginScreen.id,
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        CalculateScreen.id: (context) => CalculateScreen(),
        LoadingScreen.id: (context) => LoadingScreen(),
        SignUpScreen.id: (context) => SignUpScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        CupSizeScreen.id: (context) => CupSizeScreen(),
      },
    );
  }
}
