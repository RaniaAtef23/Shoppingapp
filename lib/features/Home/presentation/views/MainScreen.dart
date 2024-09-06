import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:shopping_app/features/Categories/views/CategoryScreen.dart';
import 'package:shopping_app/features/CartFavoriteItems/presentation/views/cart_view.dart';
import 'HomeView.dart';
import '../../../CartFavoriteItems/presentation/views/favoyrite_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeView(),
    const CategoryScreen(),
    const Cart_view(),
    const FavoritesScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        items: <Widget>[
          Icon(Icons.home_outlined, size: 35.sp, color: Colors.orange),
          Icon(Icons.category_outlined, size: 30.sp, color: Colors.orange),
          Icon(Icons.shopping_cart_outlined, size: 30.sp, color: Colors.orange),
          Icon(Icons.favorite, size: 30.sp, color: Colors.orange),
        ],
        index: _selectedIndex,
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.orange,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        onTap: _onItemTapped,
        height: 55.h,
      ),
    );
  }
}
