

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping_app/features/Home/data/models/Category.dart';

import 'package:shopping_app/features/Home/presentation/views/widgets/SmallCategoryWidget.dart';

class HorizontalCategoryList extends StatelessWidget {
  final List<Category> categories;

  const HorizontalCategoryList({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return SmallCategoryWidget(category: category);
        },
      ),
    );
  }
}
