import 'package:cuberto_bottom_bar/internal/cuberto_bottom_bar.dart';
import 'package:cuberto_bottom_bar/internal/tab_data.dart';
import 'package:flutter/material.dart';
import 'package:klik/presentaion/pages/homepage/homepage.dart';
import 'package:klik/presentaion/pages/notification_page/notification_page.dart';
import 'package:klik/presentaion/pages/profile_page/profile_page.dart';
import 'package:klik/presentaion/pages/search_page/Search_page.dart';
import 'package:klik/presentaion/pages/userpost_page/user_post.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final List pages = [
    Homepage(),
    const Search_page(),
    const UserPost(),
    const NotificationPage(),
    const ProfilePage()
  ];
  int _currentPage = 0;

  Color _currentColor = Colors.green; // Assuming 'green' is a Color constant

  @override
  Widget build(BuildContext context) {
    return CubertoBottomBar(
      key: const Key("BottomBar"),
      inactiveIconColor: _currentColor,
      tabStyle: CubertoTabStyle.styleNormal,
      selectedTab: _currentPage,
      tabs: _getTabs(), // Method to get the list of tabs
      onTabChangedListener: (position, title, color) {
        setState(() {
          _currentPage = position;

          if (color != null) {
            _currentColor = color; // Adjust color if needed
          }
        });
      },
    );
  }

  List<TabData> _getTabs() {
    // Replace with your actual tabs data
    return [
      const TabData(
        key: Key('Home'),
        iconData: Icons.home,
        title: 'Home',
        tabColor: Colors.blue, // Set color as needed
        tabGradient: null, // Set gradient if needed
      ),
      const TabData(
        key: Key('Search'),
        iconData: Icons.search,
        title: 'Search',
        tabColor: Colors.blue, // Set color as needed
        tabGradient: null, // Set gradient if needed
      ),
      // Add more tabs here
    ];
  }
}
