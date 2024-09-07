import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
import 'package:shopping_app/features/Categories/data/models/Category.dart';
import 'package:shopping_app/features/Home/presentation/views/details_screen.dart';
import 'package:shopping_app/features/Home/presentation/views/details_screen.dart';
import '../../../../core/utils/app_router.dart';
import '../CategoryProductScreen.dart';

class CategoryCard extends StatelessWidget {
  final Category category;

  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.categoryProductsScreen);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h), // Use ScreenUtil for padding
        child: Card(
          elevation: 8.0, // Slightly elevated for a modern look
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r), // Use ScreenUtil for border radius
          ),
          child: Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(20.r), // Use ScreenUtil for border radius
                child: Image.asset(
                  category.imageUrl, // Ensure this path is correct
                  fit: BoxFit.cover,
                  height: 180.h, // Use ScreenUtil for height
                  width: double.infinity,
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.2), // More transparent for better visibility
                        Colors.black.withOpacity(0.6),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20.r), // Match card border radius
                  ),
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    category.name,
                    style: TextStyle(
                      fontSize: 22.sp, // Use ScreenUtil for font size
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: const [
                        Shadow(
                          blurRadius: 8.0,
                          color: Colors.black,
                          offset: Offset(2.0, 2.0),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const Positioned(
                bottom: 16,
                right: 16,
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.orange,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
