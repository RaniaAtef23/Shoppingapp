
import 'package:flutter/material.dart';
import 'package:shopping_app/features/Home/data/models/Category.dart';
import 'package:shopping_app/features/Home/presentation/views/Screens/CategoryProductScreen.dart';
class SmallCategoryWidget extends StatelessWidget {
  final Category category;

  const SmallCategoryWidget({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryProductsScreen(category: category),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0), // Adjusted margin for better spacing
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0), // Adjusted padding for better alignment
          decoration: BoxDecoration(
            color: Colors.white, // Background color of the container
            borderRadius: BorderRadius.circular(12.0), // Rounded corners for a modern look
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3), // Shadow color
                spreadRadius: 2,
                blurRadius: 4, // Soft shadow for depth effect
                offset: const Offset(0, 3), // Shadow position
              ),
            ],
            border: Border.all(color: Colors.orange.withOpacity(0.9)), // Optional border for additional style
          ),
          child: Center(
            child: Text(
              category.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16.0, // Adjusted font size for better readability
                fontWeight: FontWeight.bold,
                color: Colors.orange, // Text color
              ),
            ),
          ),
        ),
      ),
    );
  }
}