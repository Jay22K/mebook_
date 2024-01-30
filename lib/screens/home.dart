import 'dart:convert';
import 'dart:developer';

import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:floating_navbar/floating_navbar.dart';
import 'package:floating_navbar/floating_navbar_item.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
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
  //const HomeScreen({required Key key}) : super(key: key);

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
  List<Book> fetchedBooks = []; // Create a list to hold fetched books
  List<Book> fetchedBooks2 = []; // Create a list to hold fetched books
  DataFetcher? dataFetcher;

  // void _handleIndexChanged(int i) {
  //   setState(() {
  //     _selectedTab = _SelectedTab.values[i];
  //   });
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
  }

  int _selectedIndex = 0;

  final List<Widget> _screens = [
    // Replace these with your actual screens or widgets
    Text('Home'),
    Text('Favorites'),
    Text('Search'),
    Text('Profile'),
  ];

  bool fabHovered = true;

  String? sescription;

  BookData? bookDownload;
  Books? booksdata;

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

// Function to fetch books
  Future<void> fetchBooks2(String category, int page) async {
    setState(() {
      fetchedBooks2 = []; // Set fetchedBooks to an empty list
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
        fetchedBooks2 = booksList;
      });
    } catch (e) {
      // Handle errors, if any
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
            children: <Widget>[
              DrawerHeader(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'mebook',
                      style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Poppins'),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'an open source library ',
                      style: kListTextStyle,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: ScrollConfiguration(
        // remove Bluish Scroll Glow
        behavior: CustomScroll(),
        child: SingleChildScrollView(
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              appbar(
                title: 'Hello , Jayesh!',
              ),
              HeaderWithSearchBar(
                searchController: searchController,
              ),
              ChipsFilter(
                categories: categoryList,
                onCategorySelected: (category) async {
                  setState(() {
                    selectedCategory = category;
                    // Handle category selection as needed.
                    log(selectedCategory);
                  });
                  await fetchBooks(
                      selectedCategory, 1); // Call fetchBooks function
                  await fetchBooks2(
                      selectedCategory, 2); // Call fetchBooks function
                },
              ),
              RecomendsBooks(books: fetchedBooks),
              RecomendsBooks(books: fetchedBooks2),
              // RecomendsBooks(),
              // SizedBox(height: 60)
            ],
          ),
        ),
      ),
    );
  }
}
