import 'package:cuberto_bottom_bar/internal/cuberto_bottom_bar.dart';
import 'package:cuberto_bottom_bar/internal/tab_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klik/application/core/constants/constants.dart';
import 'package:klik/presentaion/bloc/bottomanav_mainpages.dart/cubit/bottomnavigator_cubit.dart';
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
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  final List screens = [
    Homepage(),
    const Search_page(),
    const UserPost(),
    const NotificationPage(),
    const ProfilePage()
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocConsumer<BottomnavigatorCubit, BottomnavigatorState>(
      listener: (context, state) {
        if (state is BottomnavigatorInitialState) {
          currentIndex = state.index;
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: screens[currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.black,
            unselectedItemColor: theme.brightness == Brightness.dark
                ? Colors.white
                : Colors.green,
            selectedItemColor: green,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            enableFeedback: true,
            onTap: (value) {
              context
                  .read<BottomnavigatorCubit>()
                  .bottomNavigatorButtonClicked(index: value);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: "Search",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: "Add",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.diversity_3_rounded),
                label: "Suggestion",
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.person_circle),
                label: "Profile",
              )
            ],
          ),
        );
      },
    );
  }
}
