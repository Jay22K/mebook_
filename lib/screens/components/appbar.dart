import 'package:flutter/material.dart';

import '../../constants.dart';

class appbar extends StatelessWidget {
  final String title;
  final String profileUrl;

  appbar({required this.title, required this.profileUrl});

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
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle, // Change shape to circle
          ),
          padding: EdgeInsets.all(6),
          // width: 100,
          height: 100, // Ensure height is also set to make it a circle
          child: ClipOval(
            child: profileUrl.isEmpty
                ? Image.asset(
                    'assets/imgs/user.png',
                    fit: BoxFit.cover, // Ensures the image covers the circle
                  )
                : Image.network(
                    profileUrl,
                    fit: BoxFit.cover, // Ensures the image covers the circle
                  ),
          ),
        ),
        SizedBox(width: 12)
      ],
    );
  }
}
