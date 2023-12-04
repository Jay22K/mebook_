import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   title: Text('Half Screen Container'),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height /
              //     1.8, // Half of the screen height
              decoration: BoxDecoration(
                color: Colors.blue,
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
                            child: Center(
                              child: Text(
                                'Bottom Rounded Container',
                                style: TextStyle(fontSize: 16.0),
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
                            height:MediaQuery.of(context).size.width *
                            0.565,
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
          ],
        ),
      ),
    );
  }
}
