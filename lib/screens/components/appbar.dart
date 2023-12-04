import 'package:flutter/material.dart';

import '../../constants.dart';

class appbar extends StatelessWidget {
  final String title;

  appbar({required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: EdgeInsets.only(left: 10),
        child: Text(
          title,
          style: TextStyle(fontSize: 12),
        ),
      ),
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: kPrimaryColor,
      actions: [
        SizedBox(
          width: 100,
          child: Image.asset(
            'assets/imgs/user.png',
          ),
        ),
      ],
    );
  }
}
