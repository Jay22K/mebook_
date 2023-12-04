import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mebook/screens/start.dart';

import '../util/router.dart';



class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  startTimeout() {
    return new Timer(const Duration(seconds: 4), handleTimeout);
  }

  void handleTimeout() {
    changeScreen();
  }

  changeScreen() async {
    MyRouter.pushPageReplacement(
      context,
      Start(),
    );
  }

  @override
  void initState() {
    super.initState();
    startTimeout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/imgs/app-icon.png",
              height: 300.0,
              width: 300.0,
            ),
          ],
        ),
      ),
    );
  }
}
