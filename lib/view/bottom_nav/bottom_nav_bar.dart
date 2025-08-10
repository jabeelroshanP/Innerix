import 'package:flutter/material.dart';
import 'package:innerix/controller/bottom_nav_bar_provider.dart';
import 'package:innerix/view/home/home.dart';
import 'package:innerix/view/profile/profile.dart';
import 'package:innerix/view/search/search.dart';
import 'package:provider/provider.dart';


class BottomNavBar extends StatelessWidget {
    const BottomNavBar({super.key});

  final List<Widget> pages = const [
   HomePage(),
   SearchPg(),
   ProfilePg()
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavProvider>(
      builder: (context, navProvider, _) {
        return Scaffold(
          body: pages[navProvider.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: navProvider.currentIndex,
            onTap: (index) {
              navProvider.changeTab(index);
            },
            selectedItemColor: Colors.orange,
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
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
                icon: Icon(Icons.person),
                label: "Profile",
              ),
            ],
          ),
        );
      },
    );
  }
}
