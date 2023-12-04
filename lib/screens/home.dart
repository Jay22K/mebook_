import 'dart:developer';

import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:floating_navbar/floating_navbar.dart';
import 'package:floating_navbar/floating_navbar_item.dart';
import 'package:flutter/material.dart';
import 'package:mebook/services/json_parser.dart';

import '../../constants.dart';
import '../services/api_handler.dart';
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
  var _selectedTab = _SelectedTab.home;
  List<Book> fetchedBooks = []; // Create a list to hold fetched books
  List<Book> fetchedBooks2 = []; // Create a list to hold fetched books
  DataFetcher? dataFetcher;

  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = _SelectedTab.values[i];
    });
  }

// Function to fetch books
  Future<void> fetchBooks(String category) async {
    setState(() {
      fetchedBooks = []; // Set fetchedBooks to an empty list
      fetchedBooks2 = []; // Set fetchedBooks to an empty list
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

// Function to fetch books
  Future<void> fetchBooks2(String category) async {
    setState(() {
      fetchedBooks2 = []; // Set fetchedBooks to an empty list
    });
    try {
      dataFetcher = DataFetcher(query: category);
      final books = await dataFetcher!.fetchBooks();

      setState(() {
        fetchedBooks2 = books;
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
                categories: [
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
                ],
                onCategorySelected: (category) async {
                  setState(() {
                    selectedCategory = category;
                    // Handle category selection as needed.
                    log(selectedCategory);
                  });
                  await fetchBooks(
                      selectedCategory); // Call fetchBooks function
                  await fetchBooks2(
                      selectedCategory + "&page=2"); // Call fetchBooks function
                },
              ),
              RecomendsBooks(books: fetchedBooks),
              RecomendsBooks(books: fetchedBooks2),
              // RecomendsBooks(),
              SizedBox(height: 60)
            ],
          ),
        ),
      ),
      extendBody: true,
      bottomNavigationBar: DotNavigationBar(
        // margin: EdgeInsets.only(left: 10, right: 10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 10,
          )
        ],
        enablePaddingAnimation: false,
        // backgroundColor: kPrimaryColor,
        currentIndex: _SelectedTab.values.indexOf(_selectedTab),
        dotIndicatorColor: kPrimaryColor,
        unselectedItemColor: Colors.grey[300],
        splashBorderRadius: 50,
        // enableFloatingNavBar: false,
        onTap: _handleIndexChanged,
        items: [
          /// Home
          DotNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            selectedColor: kPrimaryColor,
          ),

          /// Likes
          DotNavigationBarItem(
            icon: Icon(Icons.book_rounded),
            selectedColor: kPrimaryColor,
          ),

          /// Search
          DotNavigationBarItem(
            icon: Icon(Icons.settings),
            selectedColor: kPrimaryColor,
          ),

          /// Profile
        ],
      ),
    );
  }
}
