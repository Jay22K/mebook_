import 'package:flutter/material.dart';

import '../../constants.dart';

class bookDetails extends StatelessWidget {
  const bookDetails({
    super.key,
    required this.author,
    required this.id,
    required this.image,
    required this.pages,
    required this.title,
    required this.type,
    required this.description,
  });

  final String author;
  final String id;
  final String image;
  final String pages;
  final String title;
  final String type;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height /
      //     1.8, // Half of the screen height
      decoration: BoxDecoration(
        color: kSecondColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50.0), // Rounded bottom left corner
          bottomRight: Radius.circular(50.0), // Rounded bottom right corner
        ),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    width: MediaQuery.of(context).size.width /
                        1.3, // Half of the screen width
                    height: MediaQuery.of(context).size.height / 2.32,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft:
                            Radius.circular(40.0), // Rounded top right corner
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 10,
                          left: MediaQuery.of(context).size.height / 7.2,
                          right: MediaQuery.of(context).size.width * 0.07),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            author,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 11,
                                color: Color.fromARGB(255, 37, 121, 39),
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            title,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 18,
                                color: kSecondColor,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 110,
                            height: 35, // Set your desired height
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  20), // Adjust the radius as needed
                              gradient: LinearGradient(
                                // begin: Alignment.l,

                                colors: [
                                  Color.fromRGBO(255, 242, 215, 1),
                                  Color.fromRGBO(255, 235, 187, 1)
                                ], // Replace with your desired colors
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "Pages: ${pages}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color.fromRGBO(35, 28, 7, 1),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height *
                    0.064, // Adjust the fraction as needed
                left: MediaQuery.of(context).size.width *
                    0.07, // Adjust the fraction as needed
                child: Card(
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: SizedBox(
                    width: 130,
                    height: MediaQuery.of(context).size.width * 0.6,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Stack(
                        children: [
                          Image.network(
                            image, // Replace this with your image URL
                            fit: BoxFit.fill,
                          ),
                          Positioned(
                            top: 0,
                            left: 0,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 3),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(7),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                              child: Text(
                                type,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Text(
                  "Description",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 30.0, top: 5, right: 30.0, bottom: 20),
                child: description == null
                    ? Text(
                        "________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________",
                        style: TextStyle(color: Colors.white),
                        // maxLines: 4,
                        // overflow: TextOverflow.ellipsis,
                        // style: TextStyle(fontSize: 14),
                      )
                    : Text(
                        description!,
                        style: TextStyle(color: Colors.white),
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
