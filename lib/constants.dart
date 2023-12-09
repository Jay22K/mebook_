import 'package:flutter/material.dart';

// Colors that we use in our app
const kPrimaryColor = Color(0xFF3e8657);
const kSecondColor = Color(0xFF2c3255);
const kTextColor = Color(0xFF3C4046);
const kBackgroundColor = Color(0xFFF9F8FD);
const kListTextStyle = TextStyle(
  fontWeight: FontWeight.w300,
  fontFamily: 'Poppins',
  color: Colors.white38,
);

const String imgUrl =
    "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png";
const double kDefaultPadding = 20.0;

class CustomScroll extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
