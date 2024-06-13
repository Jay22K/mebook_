import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mebook/screens/settings.dart';
import 'package:mebook/services/json_parser.dart';

import '../../constants.dart';
import '../services/api_handler.dart';
import '../services/book_json_parser.dart';
import '../util/router.dart';
import 'bookShelf.dart';
import 'components/appbar.dart';
import 'components/chips.dart';
import 'components/header_with_searchbar.dart';
import 'components/recomend_books.dart';

enum _SelectedTab { home, favorite, search, person }

class HomeScreen extends StatefulWidget {
  final String uid;
  final String userName;
  final String userphotoURL;
  final List<String> topics;

  const HomeScreen({
    required this.userName,
    required this.uid,
    required this.topics,
    required this.userphotoURL,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  String selectedCategory = "";
  List<String> categoryList = [
    'Adventure',
    'Crime',
    'Design',
    'Kids',
    'Novel',
    'Poetry',
    'Romantic',
    'Sci-Fi',
    'Spiritual',
    'Other'
  ];
  List<Book> fetchedBooks1 = [];
  List<Book> fetchedBooks2 = [];
  List<Book> fetchedBooks3 = [];
  DataFetcher? dataFetcher;

  @override
  void initState() {
    super.initState();
    fetchInitialBooks();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> fetchInitialBooks() async {
    if (widget.topics.isNotEmpty) {
      await fetchBooks(widget.topics[0], 1, fetchedBooks1);
    }
    if (widget.topics.length > 1) {
      await fetchBooks(widget.topics[1], 1, fetchedBooks2);
    }
    if (widget.topics.length > 2) {
      await fetchBooks(widget.topics[2], 1, fetchedBooks3);
    }
  }

  Future<void> fetchBooks(
      String category, int page, List<Book> bookList) async {
    bookList.clear();
    try {
      dataFetcher = DataFetcher(query: category, page: page);
      final books = await dataFetcher!.fetchBooks();
      final booksJson =
          json.decode(books.toRawJson())['books'] as List<dynamic>;
      final booksList =
          booksJson.map((bookJson) => Book.fromJson(bookJson)).toList();

      setState(() {
        bookList.clear(); // Clear the list before adding new items

        bookList.addAll(booksList);
      });
    } catch (e) {
      log('Error fetching books: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Theme(
        data: Theme.of(context).copyWith(),
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'mebook',
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'an open source library',
                      style: kListTextStyle,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: ScrollConfiguration(
        behavior: CustomScroll(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              appbar(
                title: 'Hello, ${widget.userName}',
                profileUrl: widget.userphotoURL,
              ),
              HeaderWithSearchBar(searchController: searchController),
              ChipsFilter(
                categories: categoryList,
                onCategorySelected: (category) async {
                  setState(() => selectedCategory = category);
                  await fetchBooks(selectedCategory, 1, fetchedBooks1);
                  await fetchBooks(selectedCategory, 2, fetchedBooks2);
                  await fetchBooks(selectedCategory, 3, fetchedBooks3);
                },
              ),
              RecomendsBooks(books: fetchedBooks1),
              RecomendsBooks(books: fetchedBooks2),
              RecomendsBooks(books: fetchedBooks3),
            ],
          ),
        ),
      ),
    );
  }
}
