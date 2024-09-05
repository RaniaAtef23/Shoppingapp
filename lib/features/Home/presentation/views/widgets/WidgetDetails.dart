import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shopping_app/features/Home/presentation/views/Screens/cart_view.dart';
import 'package:shopping_app/features/Home/presentation/views/widgets/cart_widget.dart';
import '../../../data/models/Products.dart';

class WidgetDetails extends StatefulWidget {
  final Products product;

  WidgetDetails({super.key, required this.product});

  @override
  State<WidgetDetails> createState() => _WidgetDetailsState();
}

class _WidgetDetailsState extends State<WidgetDetails> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          widget.product.title!,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.orange,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 350,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white,
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
                child: Image.network(
                  widget.product.images?.first ?? 'https://via.placeholder.com/150',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Center(
                    child: Icon(
                      Icons.error,
                      color: Colors.red,
                      size: 40,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.title ?? 'Product Title',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "\$${widget.product.price?.toStringAsFixed(2) ?? '0.00'}",
                        style: TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Discount: ${widget.product.discountPercentage?.toStringAsFixed(2) ?? '0.00'}%",
                        style: TextStyle(
                          color: Colors.orangeAccent,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Stock: ${widget.product.stock?.toString() ?? 'N/A'}",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        widget.product.description ?? 'Product description',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoRow("Brand", widget.product.brand ?? 'Product brand'),
                      const SizedBox(height: 8),
                      _buildInfoRow("Warranty", widget.product.warrantyInformation ?? 'N/A'),
                      const SizedBox(height: 8),
                      _buildInfoRow("Return Policy", widget.product.returnPolicy ?? 'N/A'),
                      const SizedBox(height: 8),
                      _buildInfoRow("Minimum Order Quantity", widget.product.minimumOrderQuantity?.toString() ?? 'N/A'),
                      const SizedBox(height: 16),
                      if (widget.product.meta?.qrCode != null)
                        Center(
                          child: Image.network(
                            widget.product.meta!.qrCode!,
                            height: 120,
                            width: 120,
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
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Reviews",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(height: 10),
                      if (widget.product.reviews != null && widget.product.reviews!.isNotEmpty)
                        Column(
                          children: widget.product.reviews!.map((review) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      RatingBarIndicator(
                                        rating: (review.rating ?? 0.0).toDouble(),
                                        itemBuilder: (context, index) => Icon(
                                          Icons.star,
                                          color: Colors.orange,
                                        ),
                                        itemCount: 5,
                                        itemSize: 20.0,
                                        direction: Axis.horizontal,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        "(${review.rating?.toString() ?? '0'}/5)",
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    review.comment ?? 'No comment',
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    review.date ?? 'Date not available',
                                    style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        )
                      else
                        Center(
                          child: Text(
                            'No reviews yet',
                            style: TextStyle(
                              color: Colors.black45,
                              fontSize: 16,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  minimumSize: Size(double.infinity, 50),
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
                onPressed: () {
                  CartWidget.addProduct(widget.product);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Cart_view()),
                  );
                },
                child: const Text(
                  "Add To Cart",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      children: [
        Text(
          "$label:",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: Colors.orangeAccent,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}