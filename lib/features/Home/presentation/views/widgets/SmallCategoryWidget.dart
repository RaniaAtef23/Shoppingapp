import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping_app/features/Home/data/models/Category.dart';

import '../CategoryProductScreen.dart';

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
        padding: EdgeInsets.all(8.w), // Responsive padding
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8.w), // Responsive margin for better spacing
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w), // Responsive padding
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
              style: TextStyle(
                fontSize: 12.sp, // Responsive font size for better readability
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
