import 'package:flutter/material.dart';
import 'package:shopping_app/features/Home/presentation/views/widgets/category.dart';
import '../../../data/models/Category.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  // Define the list of categories here
  final List<Category> categories = [
    Category(name: 'Beauty', imageUrl: 'assets/photo_12_2024-07-23_21-30-07.jpg'),
    Category(name: 'Fragrances', imageUrl: 'assets/photo_22_2024-07-23_21-30-07.jpg'),
    Category(name: 'Furniture', imageUrl: 'assets/photo_14_2024-07-23_21-30-07.jpg'),
    Category(name: 'Groceries', imageUrl: 'assets/photo_19_2024-07-23_21-30-07.jpg'),
    Category(name: 'Home Decoration', imageUrl: 'assets/photo_15_2024-07-23_21-30-07.jpg'),
    Category(name: 'Kitchen Accessories', imageUrl: 'assets/photo_19_2024-07-23_21-30-07.jpg'),
    Category(name: 'Laptops', imageUrl: 'assets/photo_18_2024-07-23_21-30-07.jpg'),
    Category(name: 'Mens Shirts', imageUrl: 'assets/photo_11_2024-07-23_21-30-07.jpg'),
    Category(name: 'Mens Shoes', imageUrl: 'assets/photo_10_2024-07-23_21-30-07.jpg'),
    Category(name: 'Mens Watches', imageUrl: 'assets/photo_6_2024-07-23_21-30-07.jpg'),
    Category(name: 'Mobile Accessories', imageUrl: 'assets/photo_21_2024-07-23_21-30-07.jpg'),
    Category(name: 'Motorcycle', imageUrl: 'assets/photo_13_2024-07-23_21-30-07.jpg'),
    Category(name: 'Skin Care', imageUrl: 'assets/photo_20_2024-07-23_21-30-07.jpg'),
    Category(name: 'Smartphones', imageUrl: 'assets/photo_16_2024-07-23_21-30-07.jpg'),
    Category(name: 'Sports Accessories', imageUrl: 'assets/photo_17_2024-07-23_21-30-07.jpg'),
    Category(name: 'Sunglasses', imageUrl: 'assets/photo_9_2024-07-23_21-30-07.jpg'),
    Category(name: 'Tablets', imageUrl: 'assets/photo_17_2024-07-23_21-30-07.jpg'),
    Category(name: 'Tops', imageUrl: 'assets/photo_1_2024-07-23_21-30-07.jpg'),
    Category(name: 'Vehicle', imageUrl: 'assets/photo_3_2024-07-23_21-30-07.jpg'),
    Category(name: 'Womens Bags', imageUrl: 'assets/photo_7_2024-07-23_21-30-07.jpg'),
    Category(name: 'Womens Dresses', imageUrl: 'assets/photo_5_2024-07-23_21-30-07.jpg'),
    Category(name: 'Womens Jewellery', imageUrl: 'assets/photo_4_2024-07-23_21-30-07.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Categories",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.orange,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.stacked_line_chart),
            color: Colors.orange,
            onPressed: () {
              // Add functionality for forward button
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: CategoryCard(category: categories[index]),
          );
        },
      ),
    );
  }
}