import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:laptop_harbor/core/app_data.dart';
import 'package:laptop_harbor/src/view/screen/cart_screen.dart';
import 'package:laptop_harbor/src/view/screen/register.dart';
import 'package:laptop_harbor/src/view/widget/page_wrapper.dart';
import 'package:laptop_harbor/src/view/screen/profile_screen.dart';
import 'package:laptop_harbor/src/view/screen/favorite_screen.dart';
import 'package:laptop_harbor/src/view/screen/product_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const List<Widget> screens = [
    ProductListScreen(),
    FavoriteScreen(),
    CartScreen(),
    ProfileScreen()
  ];

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int newIndex = 0;
  bool _isLoggedIn = false; // Add a flag to track login status

  @override
  void initState() {
    super.initState();
    _checkLoginStatus(); // Check login status when the screen is initialized
  }

  Future<void> _checkLoginStatus() async {
    final user = await FirebaseAuth.instance.currentUser;
    if (user != null) {
      _isLoggedIn = true;
    } else {
      _isLoggedIn = false;
    }
    setState(() {}); // Update the UI
  }

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      child: Scaffold(
        bottomNavigationBar: BottomNavyBar(
          itemCornerRadius: 10,
          selectedIndex: newIndex,
          items: AppData.bottomNavyBarItems
              .map(
                (item) => BottomNavyBarItem(
                  icon: item.icon,
                  title: Text(item.title),
                  activeColor: item.activeColor,
                  inactiveColor: item.inActiveColor,
                ),
              )
              .toList(),
          onItemSelected: (currentIndex) {
            newIndex = currentIndex;
            setState(() {});
          },
        ),
        body: PageTransitionSwitcher(
          duration: const Duration(seconds: 1),
          transitionBuilder: (
            Widget child,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return FadeThroughTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              child: child,
            );
          },
          child: _isLoggedIn
             ? HomeScreen.screens[newIndex]
              : newIndex == 3
                 ? const LoginRegisterScreen() // Show Register/Login screen if not logged in
                  : HomeScreen.screens[newIndex],
        ),
      ),
    );
  }
}
