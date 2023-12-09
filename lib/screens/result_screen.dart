import 'dart:developer';

import 'package:flutter/material.dart';
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
  @override
  void initState() {
    super.initState();
    searchController.text = widget.query!;
    fetchBooks(widget.query!);
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          appbar(title: 'Hello , Jayesh!'),
          appbarForResultScreen(
            onSearchPressed: () {
              fetchBooks(searchController.text);
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
        ],
      ),
    );
  }
}
