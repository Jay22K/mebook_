import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mebook/screens/components/recomend_books.dart';
import 'package:shimmer/shimmer.dart';

import '../constants.dart';
import '../services/api_handler.dart';
import '../services/book_json_parser.dart';
import '../services/json_parser.dart';

class DetailsScreen extends StatefulWidget {
  final String author, id, image, pages, publisher, title, type, year;

  DetailsScreen(
      {super.key,
      required this.author,
      required this.id,
      required this.image,
      required this.pages,
      required this.publisher,
      required this.title,
      required this.type,
      required this.year});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  Widget _buildShimmerLine() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        width: double.infinity,
        height: 12.0,
        color: kSecondColor, // You can set any color here
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchBooks(widget.author);
    downloadBook(widget.id);
  }

  bool fabHovered = true;
  List<Book> fetchedBooks = [];
  String? sescription;
  DataFetcher? dataFetcher;
  BookData? bookDownload;

  String? downloadUrl, description, bookinfo;

// Function to fetch books
  Future<void> fetchBooks(String category) async {
    setState(() {
      fetchedBooks = []; // Set fetchedBooks to an empty list
    });
    try {
      dataFetcher = DataFetcher(query: category);
      final books = await dataFetcher!.fetchBooks();

      setState(() {
        fetchedBooks = books;
      });
    } catch (e) {
      // Handle errors, if any
      log('Error fetching books: $e');
    }
  }

  Future<void> downloadBook(String id) async {
    try {
      final downloadLink = await dataFetcher!.downloadBook(id);
      bookDownload = downloadLink;
      // Extracting values from JSON response
      bookinfo = bookDownload!.toRawJson();
      // Extracting values from JSON response
      Map<String, dynamic> decodedJson = jsonDecode(bookinfo!);

      // Extract 'description' and 'download' from the decoded JSON
      setState(() {
        description = decodedJson['description'];
        downloadUrl = decodedJson['download'];
      });

      // Now you can use the 'description' and 'downloadUrl' as needed
      // print('Description: $description');
      // print('Download URL: $downloadUrl');
      // log("book info :" + bookDownload!.toRawJson());
    } catch (e) {
      log('Error fetching book Description: $e');
    }
  }

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
                            height: MediaQuery.of(context).size.height / 2.32,
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
                                    widget.author,
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
                                    widget.title,
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
                                        "Pages: ${widget.pages}",
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
                              child: Image.network(
                                widget
                                    .image, // Replace this with your image URL
                                fit: BoxFit.fill,
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
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Text(
                "Similar  Auther",
                style: TextStyle(
                    color: kSecondColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 30),
            RecomendsBooks(books: fetchedBooks),
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

            print("book URL : " + downloadUrl!);
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
                    widget.type,
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
