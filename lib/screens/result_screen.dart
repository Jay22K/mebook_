import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mebook/constants.dart';

import 'components/appbar.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    String searchString = '';

    return Scaffold(
      
        body: ScrollConfiguration(
      behavior: CustomScroll(),
      child: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          
          appbar(title: 'Hello , Jayesh!',),
          Container(
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
                // SizedBox(
                //   height: MediaQuery.of(context).size.height,
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                //     children: <Widget>[
                //       Padding(
                //         padding: const EdgeInsets.only(
                //             left: 20, right: 20, bottom: 70),
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: const [
                //             Text(
                //               "The best\nBooks for you!",
                //               style: TextStyle(
                //                   fontSize: 30,
                //                   color: kBackgroundColor,
                //                   fontWeight: FontWeight.bold),
                //             ),
                //             SizedBox(
                //               height: 10,
                //             ),
                //             Text(
                //               "Search your favorites novels, techbooks, and story",
                //               style: TextStyle(
                //                 //fontSize: 19.5,
                //                 color: kBackgroundColor,
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Container(
                    alignment: Alignment.center,
                    margin:
                        const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    padding: const EdgeInsets.only(right: kDefaultPadding),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      // ignore: prefer_const_literals_to_create_immutables
                      // boxShadow: [
                      //   BoxShadow(
                      //     offset: Offset(0, 10),
                      //     blurRadius: 80,
                      //     color: Color(0xFF000000),
                      //   ),
                      // ],
                    ),
                    child: Row(
                      children: <Widget>[
                        // SvgPicture.asset("assets/imgs/search.svg"),
                        IconButton(
                          onPressed: () {
                            if (searchString != '') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ResultScreen()));
                            }
                          },
                          icon: SvgPicture.asset("assets/imgs/search.svg"),
                        ),

                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextField(
                            controller: TextEditingController()
                              ..text = searchString,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black45.withOpacity(0.5),
                            ),
                            onChanged: (value) {
                              searchString = value;
                            },
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
          ),
           //TODO:dev 
        ],
      )),
    ));
  }
}
