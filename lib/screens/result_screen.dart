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
  DataFetcher? dataFetcher;
  int currentPage = 1;
  @override
  void initState() {
    super.initState();
    searchController.text = widget.query!;
    fetchBooks(widget.query!, currentPage);
  }

// Function to fetch books
  Future<void> fetchBooks(String category, int page) async {
    setState(() {
      fetchedBooks = []; // Set fetchedBooks to an empty list
    });
    try {
      dataFetcher = DataFetcher(query: category, page: page);
      final books = await dataFetcher!.fetchBooks();

      setState(() {
        fetchedBooks = books;
      });
    } catch (e) {
      // Handle errors, if any
      log('Error fetching books: $e');
    }
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
        children: <Widget>[
          // appbar(title: 'Hello , Jayesh!'),
          appbarForResultScreen(
            onSearchPressed: () {
              fetchBooks(searchController.text, currentPage);
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Pagination(
              height: 30,
              // width: 20,
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
              },
              useGroup: false,
              totalPage: 10,
              show: 2,
              currentPage: currentPage,
            ),
          )
        ],
      ),
    );
  }
}
