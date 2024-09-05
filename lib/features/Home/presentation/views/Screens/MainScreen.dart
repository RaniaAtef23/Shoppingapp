
import 'package:flutter/material.dart';

import 'package:shopping_app/features/Home/presentation/views/Screens/CategoryScreen.dart';
import 'package:shopping_app/features/Home/presentation/views/Screens/HomeView.dart';
import 'package:shopping_app/features/Home/presentation/views/Screens/cart_view.dart';
import 'package:shopping_app/features/Home/presentation/views/Screens/favoyrite_screen.dart'; // Ensure the import paths are correct

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0; // Track the selected tab

  final List<Widget> _pages = [
    const HomeView(), // Assuming HomeView contains your Home screen
    const CategoryScreen(), // Pass categories here or use a placeholder
    const Cart_view(), // Implement this screen
    const FavoritesScreen(), // Implement this screen
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
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.black,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}