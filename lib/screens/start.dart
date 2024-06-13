import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mebook/constants.dart';

import 'package:mebook/screens/home.dart';
import 'package:mebook/screens/selectTopic.dart';
import 'package:mebook/screens/auths_screen.dart';
import 'package:mebook/util/router.dart';

import '../util/storeageService.dart';
import 'dashboard.dart';

class Start extends StatelessWidget {
  final storageService = StorageService();

  Future<void> checkUser(BuildContext context) async {
    final storageService =
        StorageService(); // Instantiate StorageService if not already done

    String? userId = await storageService.getString('uid');
    List<String>? topics = await storageService.getStringList('selectedTopics');

    if (userId != null) {
      log(userId); // Log userId only if it's not null
      log(topics.toString()); // Log topics only if it's not null

      if (topics != null) {
        MyRouter.pushPageReplacement(
          context,
          DashboardScreen(uid: userId, topics: topics),
        );
      } else {
        MyRouter.pushPageReplacement(
          context,
          TopicSelectionScreen(uid: userId),
        );
      }
    } else {
      MyRouter.pushPageReplacement(context, SignUpScreen());
    }
  }

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
                  checkUser(context);
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
