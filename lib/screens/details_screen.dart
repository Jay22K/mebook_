import 'package:flutter/material.dart';

import '../constants.dart';

class DetailsScreen extends StatelessWidget {
  DetailsScreen({super.key});
  bool fabHovered = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   title: Text('Half Screen Container'),
      // ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height /
              //     1.8, // Half of the screen height
              decoration: BoxDecoration(
                color: kSecondColor,
                borderRadius: BorderRadius.only(
                  bottomLeft:
                      Radius.circular(50.0), // Rounded bottom left corner
                  bottomRight:
                      Radius.circular(50.0), // Rounded bottom right corner
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
                            height: MediaQuery.of(context).size.height / 2.45,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(
                                    40.0), // Rounded top right corner
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height / 10,
                                  left:
                                      MediaQuery.of(context).size.height / 7.2,
                                  right:
                                      MediaQuery.of(context).size.width * 0.07),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Diane Lindsey Reeves, Lindsey Clasen, Nancy Bond',
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
                                    'Career Ideas for Kids Who Like Adventure and Travel',
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
                                        "Pages: 203",
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
                            height: MediaQuery.of(context).size.width * 0.565,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.network(
                                'https://via.placeholder.com/150', // Replace this with your image URL
                                fit: BoxFit.cover,
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
                        child: Text(
                          "Explore what Flutter has to offer, where it came from, and where it’s going. Mobile development is progressing at a fast rate and with Flutter – an open-source mobile application development SDK created by Google – you can develop applications for Android and iOS, as well as Google Fuchsia.Learn to create three apps (a personal information manager, a chat system, and a game project) that you can install on your mobile devices and use for real",
                          style: TextStyle(color: Colors.white),
                          // maxLines: 4,
                          // overflow: TextOverflow.ellipsis,
                          // style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Text(
                "Similar Books",
                style: TextStyle(color: kSecondColor, fontSize: 20, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        // padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.only(
          right: fabHovered ? 16.0 : 0.0, // Adjust the margin as needed
        ),
        child: FloatingActionButton(
          elevation: 5,
          backgroundColor: kSecondColor,
          onPressed: () {
            // Handle FAB tap
          },
          child: Icon(Icons.file_download),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFFb3f1c8),
        // shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            // mainAxisSize: MainAxisSize.max,
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                width: 20,
              ),
              Text(
                "Download this book",
                style:
                    TextStyle(color: kSecondColor, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: 70,
                height: 35, // Set your desired height
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(20), // Adjust the radius as needed
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
                    "PDF",
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
    );
  }
}
