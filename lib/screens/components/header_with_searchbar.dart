import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

import '../result_screen.dart';

class HeaderWithSearchBar extends StatelessWidget {
  final TextEditingController searchController;

  const HeaderWithSearchBar({super.key, required this.searchController});

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double availableHeight =
        MediaQuery.of(context).size.height - kToolbarHeight;

    // Define responsive values based on screen width and height
    double headerHeight =
        availableHeight * 0.28; // Adjust the percentage as needed
    double searchBarHeight = 50;
    double searchBarPadding = 20;

    return LayoutBuilder(
      builder: (context, constraints) {

        return SizedBox(
          height: headerHeight,
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                  top: 10 + kDefaultPadding,
                  left: 5 + kDefaultPadding,
                  right: 5 + kDefaultPadding,
                  bottom: headerHeight - searchBarHeight - searchBarPadding,
                ),
                height: availableHeight,
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(50),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: searchBarPadding,
                  right: searchBarPadding,
                  bottom: searchBarHeight + searchBarPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "The best\nBooks for you!",
                      style: TextStyle(
                        fontSize: height / 25,
                        color: kBackgroundColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Spacer(),
                    // SizedBox(
                    //   height: height,
                    // ),
                    const Spacer(),
                    const Text(
                      "Search your favorites novels, textbooks, and story",
                      style: TextStyle(
                        color: kBackgroundColor,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              Positioned(
                bottom: searchBarPadding,
                left: 0,
                right: 0,
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: searchBarPadding),
                  padding: EdgeInsets.only(right: searchBarPadding),
                  height: searchBarHeight,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          //TODO: change route
                          final searchString = searchController.text;
                          if (searchString.isNotEmpty) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ResultScreen(
                                          query: searchString,
                                        )));
                          }
                        },
                        icon: SvgPicture.asset("assets/imgs/search.svg"),
                      ),
                      // SizedBox(
                      //   width: 5
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
