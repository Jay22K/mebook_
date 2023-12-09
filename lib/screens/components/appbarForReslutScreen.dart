import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants.dart';

class appbarForResultScreen extends StatelessWidget {
  final TextEditingController searchController;
  final VoidCallback onSearchPressed;
  appbarForResultScreen({
    super.key,
    required this.searchController,
    required this.onSearchPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: const EdgeInsets.only(bottom: kDefaultPadding * 2),
      height: MediaQuery.of(context).size.height * 0.12,
      child: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(
              top: 10 + kDefaultPadding,
              left: 5 + kDefaultPadding,
              right: 5 + kDefaultPadding,
              bottom: 80 + kDefaultPadding,
            ),
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.only(
                //bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              padding: const EdgeInsets.only(right: kDefaultPadding),
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: <Widget>[
                  // SvgPicture.asset("assets/imgs/search.svg"),
                  IconButton(
                    onPressed:
                        onSearchPressed, // Call the callback function// Call the callback function
                    icon: SvgPicture.asset("assets/imgs/search.svg"),
                  ),

                  // SizedBox(
                  //   width: 10,
                  // ),
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black45.withOpacity(0.5),
                      ),
                      decoration: InputDecoration(
                        hintText: "Search by author, name, books",
                        hintStyle: TextStyle(
                          fontSize: 17,
                          color: Colors.black45.withOpacity(0.5),
                        ),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  //SvgPicture.asset("assets/imgs/search.svg"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
