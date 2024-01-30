import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mebook/screens/settings.dart';

import 'bookShelf.dart';
import 'home.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late PageController _pageController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          HomeScreen(),
          BookShelfScreen(),
          SettingsScreen(),
        ],
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
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
                  onPressed: () {
                    _onTabTapped(1);
                  },
                ),
                GButton(
                  icon: Icons.settings,
                  text: 'Settings',
                  iconColor: Color(0xff9d9686),
                  onPressed: () {
                    _onTabTapped(2);
                  },
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: _onTabTapped,
            ),
          ),
        ),
      ),
    );
  }

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(
        index,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }
}
