import 'dart:developer';

import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:floating_navbar/floating_navbar.dart';
import 'package:floating_navbar/floating_navbar_item.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
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

// Function to fetch books
  Future<void> fetchBooks(String category) async {
    setState(() {
      fetchedBooks = []; // Set fetchedBooks to an empty list
      fetchedBooks2 = []; // Set fetchedBooks to an empty list
    });

    //TODO:  need to implement this
    try {
      dataFetcher = DataFetcher(query: category, page: 1);
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
    //TODO:  need to implement this
    try {
      dataFetcher = DataFetcher(query: category, page: 1);
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
                categories: categoryList,
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
              // SizedBox(height: 60)
            ],
          ),
        ),
      ),
      // extendBody: true,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white, // Adjust this to match your design
          // boxShadow: [
          //   BoxShadow(
          //     blurRadius: 20,
          //     color: Colors.black.withOpacity(0.1),
          //   ),
          // ],
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              gap: 8,
              activeColor: Color(0xff9d9686),
              iconSize: 34,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              duration: Duration(milliseconds: 500),
              tabBackgroundColor: Color(0xffe4e0cf),
              tabs: [
                GButton(
                  icon: Icons.home,
                  iconColor: Color(0xff9d9686),
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.book_rounded,
                  text: 'Favorites',
                  iconColor: Color(0xff9d9686),
                ),
                GButton(
                  icon: Icons.settings,
                  text: 'Settings',
                  iconColor: Color(0xff9d9686),
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
