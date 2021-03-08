import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';

class LandingPage extends StatefulWidget {
  @override
  LandingPageState createState() => new LandingPageState();
}

class LandingPageState extends State<LandingPage> {
  
  @override
  void initState() {
    super.initState();
    
    _initializeTimer();
  }

  void _initializeTimer() {
    Timer(const Duration(seconds: 7), () => Navigator.pushReplacementNamed(context, "/welcome_page"));
    // Timer(const Duration(seconds: 5), () => Navigator.pushReplacementNamed(context, "/dashboard"));
  }

  @override
  Widget build (BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            
            SvgPicture.asset(
              "assets/imgs/icons/spicy_guitar_logo.svg",
            ),

          ],
        ),
      ),
    );
  }

}