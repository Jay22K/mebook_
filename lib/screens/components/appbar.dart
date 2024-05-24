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
        SizedBox(
          width: 100,
          child:CircleAvatar(
                  radius: 48, // Image radius
                  foregroundImage: NetworkImage(profileUrl),
                  backgroundImage: 
                  AssetImage('assets/imgs/user.png'), // Image path
                )
             
        ),
      ],
    );
  }
}
