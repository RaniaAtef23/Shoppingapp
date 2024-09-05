import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping_app/features/CartFavoriteItems/presentation/views/cart_view.dart';
import 'package:shopping_app/features/CartFavoriteItems/presentation/views/widgets/cart_widget.dart';
import '../../../data/models/Products.dart';
class WidgetDetails extends StatefulWidget {
  final Products product;

  const WidgetDetails({super.key, required this.product});

  @override
  State<WidgetDetails> createState() => _WidgetDetailsState();
}

class _WidgetDetailsState extends State<WidgetDetails> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isFavorited = false;
  bool isInCart = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    ScreenUtil.init(context, designSize: const Size(360, 690), minTextAdapt: true); // Initialize ScreenUtil

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          widget.product.title!,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.orange,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Product Image
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.r)), // Use responsive radius
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.r)),
                child: Image.network(
                  widget.product.images?.first ?? 'https://via.placeholder.com/150',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Center(
                    child: Icon(
                      Icons.error,
                      color: Colors.red,
                      size: 40,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h), // Use responsive height
            // Product Information
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w), // Use responsive width
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product title and price
                  Text(
                    widget.product.title ?? 'Product Title',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h), // Use responsive height
                  Text(
                    "\$${widget.product.price?.toStringAsFixed(2) ?? '0.00'}",
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: Colors.orange,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 16.h), // Use responsive height
                  // Tab Bar
                  TabBar(
                    controller: _tabController,
                    labelColor: Colors.orange,
                    unselectedLabelColor: Colors.black54,
                    indicatorColor: Colors.orange,
                    tabs: const [
                      Tab(text: 'Details'),
                      Tab(text: 'Reviews'),
                    ],
                  ),
                  // TabBarView
                  SizedBox(
                    height: 300.h, // Set a fixed height for the TabBarView
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _buildDetailsTab(),
                        _buildReviewsTab(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(
                Icons.favorite,
                color: isFavorited ? Colors.red : Colors.grey,
              ),
              onPressed: toggleFavorite,
            ),
            IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: isInCart ? Colors.orange : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  isInCart = !isInCart;
                });
                if (isInCart) {
                  CartWidget.addProduct(widget.product);
                } else {
                  // Handle removal from cart if needed
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Cart_view()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Function to toggle favorite status
  void toggleFavorite() {
    setState(() {
      isFavorited = !isFavorited;
      if (isFavorited) {
        // Example: FavoritesScreen.addFavorite(widget.product);
      } else {
        // Example: FavoritesScreen.removeFavorite(widget.product);
      }
    });
  }

  // Details Tab
  Widget _buildDetailsTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.w), // Use responsive width
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Description",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h), // Use responsive height
            Text(
              widget.product.description ?? 'No description available',
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 16, // Adjusted for ScreenUtil if needed
              ),
            ),
            SizedBox(height: 16.h), // Use responsive height
            // More information
            _buildInfoRow("Brand", widget.product.brand ?? 'Product brand'),
            SizedBox(height: 5.h), // Use responsive height
            _buildInfoRow("Warranty", widget.product.warrantyInformation ?? 'N/A'),
            SizedBox(height: 5.h), // Use responsive height
            _buildInfoRow("Return Policy", widget.product.returnPolicy ?? 'N/A'),
            SizedBox(height: 5.h), // Use responsive height
            _buildInfoRow("Minimum Order Quantity", widget.product.minimumOrderQuantity?.toString() ?? 'N/A'),
          ],
        ),
      ),
    );
  }

  // Reviews Tab
  Widget _buildReviewsTab() {
    return Padding(
      padding: EdgeInsets.all(16.w), // Use responsive width
      child: widget.product.reviews != null && widget.product.reviews!.isNotEmpty
          ? ListView.builder(
        itemCount: widget.product.reviews!.length,
        itemBuilder: (context, index) {
          final review = widget.product.reviews![index];
          return Padding(
            padding: EdgeInsets.only(bottom: 16.h), // Use responsive height
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    RatingBarIndicator(
                      rating: (review.rating ?? 0.0).toDouble(),
                      itemBuilder: (context, index) => const Icon(
                        Icons.star,
                        color: Colors.orange,
                      ),
                      itemCount: 5,
                      itemSize: 20.0,
                      direction: Axis.horizontal,
                    ),
                    SizedBox(width: 8.w), // Use responsive width
                    Text(
                      "(${review.rating?.toString() ?? '0'}/5)",
                      style: const TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h), // Use responsive height
                Text(
                  review.comment ?? 'No comment',
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 8.h), // Use responsive height
                Text(
                  review.date ?? 'Date not available',
                  style: const TextStyle(
                    color: Colors.black45,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          );
        },
      )
          : const Center(
        child: Text(
          'No reviews yet',
          style: TextStyle(
            color: Colors.black45,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  // Function to build rows for information
  Row _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
