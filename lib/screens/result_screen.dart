import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_pagination/flutter_pagination.dart';
import 'package:flutter_pagination/widgets/button_styles.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mebook/constants.dart';

import '../services/api_handler.dart';
import '../services/json_parser.dart';
import 'components/appbar.dart';
import 'components/appbarForReslutScreen.dart';
import 'components/bookAdapter.dart';

class ResultScreen extends StatefulWidget {
  final String? query;

  ResultScreen({super.key, required this.query});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final searchController = TextEditingController();
  List<Book> fetchedBooks = [];
  Books? booksdata;
  DataFetcher? dataFetcher;
  int currentPage = 1;

  int limit = 0;
  String result = "";
  int status = 0;
  int totalFiles = 0;
  int totalPages = 0;
  int show = 0;

  @override
  void initState() {
    super.initState();
    searchController.text = widget.query!;
    fetchBooks(widget.query!, 1);
    totalPages = 0;
  }

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

        currentPage = page;
      });

      limit = jsonMap['limit'];
      result = jsonMap['result'];
      status = jsonMap['status'];
      totalFiles = jsonMap['totalFiles'];
      totalPages = jsonMap['totalPages'];

      updateShow(totalPages);
    } catch (e) {
      // Handle errors, if any
      log('Error fetching books: $e');
    }
  }

  void updateShow(int totalPages) {
    int showValue = 1;

    if (totalPages >= 2 && totalPages <= 4) {
      showValue = totalPages - 1;
    } else if (totalPages >= 5 && totalPages <= 6) {
      showValue = totalPages - 2;
    } else if (totalPages >= 7) {
      showValue = 5;
    }

    setState(() {
      show = showValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 243, 243, 243),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kPrimaryColor,
        title: Text('Search any Books here...'),
      ),
      body: Column(
        children: [
          // appbar(title: 'Hello , Jayesh!'),
          appbarForResultScreen(
            onSearchPressed: () {
              fetchBooks(searchController.text, 1);
            },
            searchController: searchController,
          ),
          //TODO:dev
          Expanded(
            child: fetchedBooks.isEmpty
                ? bookAdaptorShimmer() // Display shimmer when fetchedBooks is empty
                : ListView.builder(
                    itemCount: fetchedBooks.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      final book = fetchedBooks[index];
                      return BookAdaptor(
                        author: book.author,
                        id: book.id,
                        image: book.image,
                        title: book.title,
                        year: book.year,
                        pages: book.pages,
                        publisher: book.publisher,
                        type: book.type,
                      );
                    },
                  ),
          ),
          if (totalPages == 0 || totalPages == 1)
            Container()
          else
            Container(
              height: 36,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Pagination(
                  // height: 30,
                  width: MediaQuery.of(context).size.width * .7,
                  paginateButtonStyles: PaginateButtonStyles(
                      backgroundColor: kPrimaryColor,
                      activeBackgroundColor: kSecondColor),
                  prevButtonStyles: PaginateSkipButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        size: 13,
                      ),
                      buttonBackgroundColor: kPrimaryColor,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20))),
                  nextButtonStyles: PaginateSkipButton(
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        size: 13,
                      ),
                      buttonBackgroundColor: kPrimaryColor,
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  onPageChange: (number) {
                    setState(() {
                      currentPage = number;
                    });
                    fetchBooks(searchController.text, currentPage);
                  },

                  useGroup: true,
                  totalPage: totalPages,
                  show: show,
                  currentPage: currentPage,
                ),
              ),
            )
        ],
      ),
    );
  }
}
