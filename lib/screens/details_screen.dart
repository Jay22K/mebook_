import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';

import 'package:mebook/screens/components/recomend_books.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shimmer/shimmer.dart';

import '../constants.dart';
import '../services/api_handler.dart';
import '../services/bookModel.dart';
import '../services/book_json_parser.dart';
import '../services/json_parser.dart';

import '../util/sesstion_settings.dart';
import 'components/bookDetails.dart';
import 'components/toast.dart';

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
    fetchBooks(widget.author, 1);
    downloadBook(widget.id);
  }

  bool fabHovered = true;
  List<Book> fetchedBooks = [];
  String? sescription;
  DataFetcher? dataFetcher;
  BookData? bookDownload;
  Books? booksdata;
  // final SessionSettings settings = SessionSettings();
  int limit = 0;
  String result = "";
  int status = 0;
  int totalFiles = 0;
  int totalPages = 0;

  String? downloadUrl, description, bookinfo;

// Function to fetch books
  Future<void> fetchBooks(String category, int page) async {
    setState(() {
      fetchedBooks = []; // Set fetchedBooks to an empty list
    });
    try {
      dataFetcher = DataFetcher(query: category, page: page);
      final books = await dataFetcher!.fetchBooks();
      booksdata = books;

      String bookdataresponse =
          booksdata!.toRawJson(); // this is  string json response

      // Convert the JSON string to a map
      Map<String, dynamic> jsonMap = json.decode(bookdataresponse);

      // Access the "books" list from the JSON and convert it to a List<Book>
      List<dynamic> booksJson = jsonMap['books'];
      List<Book> booksList =
          booksJson.map((bookJson) => Book.fromJson(bookJson)).toList();

      // Update fetchedBooks with the retrieved books list
      setState(() {
        fetchedBooks = booksList;
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
            bookDetails(
              description: description,
              id: widget.id,
              author: widget.author,
              image: widget.image,
              pages: widget.pages,
              title: widget.title,
              type: widget.type,
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

            ToastShow(msg: 'Book is Downloading').showToast(context);
            FileDownloader.downloadFile(
                url: downloadUrl!,
                downloadDestination: DownloadDestinations.appFiles,
                notificationType: NotificationType.all,
                onProgress: (name, progress) {
                  log("file name : " + name.toString());
                  log('Progress: $progress%');
                },
                onDownloadCompleted: (path) {
                  log("downloaded to : " + path.toString());
                  // _storeBookContent(filePath: path);
                  ToastShow(msg: 'Downloading Successful..!')
                      .showToast(context);
                },
                onDownloadError: (error) {
                  log('Download error: $error');
                  ToastShow(
                          msg:
                              'Downloading is canceled or failed due to network issues')
                      .showToast(context);
                }).then(
              (file) {
                debugPrint('file path: ${file?.path}');
              },
            );
            log("book URL : " + downloadUrl!);
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
