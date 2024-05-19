import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mebook/constants.dart';

import 'package:mebook/screens/home.dart';
import 'package:mebook/screens/selectTopic.dart';
import 'package:mebook/screens/singup_screen.dart';
import 'package:mebook/util/router.dart';

import 'dashboard.dart';

class Start extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: SizedBox(
              height: 40,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              width: double.infinity,
              child: Lottie.asset(
                'assets/imgs/boy_studying.json',
              ),
            ),
          ),
          Expanded(
            flex: 0,
            child: Container(
              width: double.infinity,
              child: Center(
                child: Text(
                  "Begin Your journey",
                  style: TextStyle(fontFamily: 'Utopia', fontSize: 38),
                ),
              ),
            ),
          ),
          Container(
              padding: EdgeInsets.all(20),
              child: Text(
                'Mebook App is a collection of ebooks for increasing Knowledge without an unacceptable reduction in comprehension.',
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: "Work_Sans", fontSize: 18.5),
              )),
          Expanded(
            flex: 0,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: MaterialButton(
                height: 58,
                minWidth: 340,
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(40)),
                onPressed: () {
                  //TODO: repleace to push page replesment
                  // MyRouter.pushPage(context, TopicSelectionScreen());
                  MyRouter.pushPage(context, SignUpScreen());

                  // MyRouter.pushPageReplacement(context, DashboardScreen());
                },
                child: Text(
                  "Start Reading",
                  style: TextStyle(
                      fontSize: 24,
                      color: kBackgroundColor,
                      fontFamily: 'Utopia'),
                ),
                color: kPrimaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
