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
            fontSize: 20.sp, // Responsive font size
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
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.r)), // Responsive radius
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
            SizedBox(height: 20.h), // Responsive height
            // Product Information
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w), // Responsive padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product title and price
                  Text(
                    widget.product.title ?? 'Product Title',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22.sp, // Responsive font size
                    ),
                  ),
                  SizedBox(height: 8.h), // Responsive height
                  Text(
                    "\$${widget.product.price?.toStringAsFixed(2) ?? '0.00'}",
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: Colors.orange,
                      fontWeight: FontWeight.w700,
                      fontSize: 20.sp, // Responsive font size
                    ),
                  ),
                  SizedBox(height: 16.h), // Responsive height
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
                    height: 300.h, // Responsive height for TabBarView
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
            InkWell(
              onTap: () {
                setState(() {
                  isInCart = !isInCart;
                });
                if (isInCart) {
                  CartWidget.addProduct(widget.product);
                }
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset("assets/Animation - 1725631509849.gif"),
                          Text(
                            'Success',
                            style: TextStyle(
                              color: const Color(0xFF101623),
                              fontWeight: FontWeight.w700,
                              fontSize: 18.sp, // Responsive font size
                              fontFamily: 'Comfortaa',
                            ),
                          ),
                          Center(
                            child: Text(
                              'Product has been added to your cart successfully!',
                              style: TextStyle(
                                color: const Color(0xFFA1A8B0),
                                fontWeight: FontWeight.w400,
                                fontSize: 16.sp, // Responsive font size
                                fontFamily: 'Comfortaa',
                              ),
                            ),
                          ),
                        ],
                      ),
                      actions: [
                        Center(
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Cart_view())); // Close the dialog
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.orange,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r), // Responsive border radius
                              ),
                              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 50.w), // Responsive padding
                            ),
                            child: Text(
                              "Done",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 16.sp, // Responsive font size
                                fontFamily: 'Comfortaa',
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Container(
                width: 300.w, // Responsive width
                height: 45.h, // Responsive height
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(10.r), // Responsive border radius
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 2.r, // Responsive spread radius
                      blurRadius: 5.r, // Responsive blur radius
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    "Add To Cart",
                    style: TextStyle(
                      fontSize: 18.sp, // Responsive font size
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 5.h), // Responsive height
          ],
        ),
      ),
    );
  }

  // Details Tab
  Widget _buildDetailsTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.w), // Responsive padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Description",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp, // Responsive font size
              ),
            ),
            SizedBox(height: 8.h), // Responsive height
            Text(
              widget.product.description ?? 'No description available',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 16.sp, // Responsive font size
              ),
            ),
            SizedBox(height: 16.h), // Responsive height
            // More information
            _buildInfoRow("Brand", widget.product.brand ?? 'Product brand'),
            SizedBox(height: 5.h), // Responsive height
            _buildInfoRow("Warranty", widget.product.warrantyInformation ?? 'N/A'),
            SizedBox(height: 5.h), // Responsive height
            _buildInfoRow("Return Policy", widget.product.returnPolicy ?? 'N/A'),
            SizedBox(height: 5.h), // Responsive height
            _buildInfoRow("Minimum Order Quantity", widget.product.minimumOrderQuantity?.toString() ?? 'N/A'),
          ],
        ),
      ),
    );
  }

  // Reviews Tab
  Widget _buildReviewsTab() {
    return Padding(
      padding: EdgeInsets.all(16.w), // Responsive padding
      child: widget.product.reviews != null && widget.product.reviews!.isNotEmpty
          ? ListView.builder(
        itemCount: widget.product.reviews!.length,
        itemBuilder: (context, index) {
          final review = widget.product.reviews![index];
          return Padding(
            padding: EdgeInsets.only(bottom: 16.h), // Responsive padding
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
                      itemSize: 20.0.r, // Responsive item size
                      direction: Axis.horizontal,
                    ),
                    SizedBox(width: 8.w), // Responsive width
                    Text(
                      "(${review.rating?.toString() ?? '0'}/5)",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp, // Responsive font size
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h), // Responsive height
                Text(
                  review.comment ?? 'No comment provided',
                  style: TextStyle(fontSize: 16.sp), // Responsive font size
                ),
              ],
            ),
          );
        },
      )
          : Center(
        child: Text(
          'No reviews available.',
          style: TextStyle(fontSize: 16.sp), // Responsive font size
        ),
      ),
    );
  }

  // Build information row
  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.sp, // Responsive font size
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: Colors.black54,
            fontSize: 16.sp, // Responsive font size
          ),
        ),
      ],
    );
  }
}
