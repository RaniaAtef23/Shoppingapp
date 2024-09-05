import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
import '../../../../Home/data/models/Products.dart';

class CartWidget extends StatefulWidget {
  static ValueNotifier<List<Products>> cartProductsNotifier = ValueNotifier([]);

  static void addProduct(Products product) {
    if (!cartProductsNotifier.value.contains(product)) {
      cartProductsNotifier.value = [...cartProductsNotifier.value, product];
    }
  }

  static void removeProduct(Products product) {
    cartProductsNotifier.value =
        cartProductsNotifier.value.where((p) => p != product).toList();
  }

  const CartWidget({super.key});

  @override
  _CartWidgetState createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  Map<Products, int> productQuantities = {}; // Track quantities of each product

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Cart Items',
          style: TextStyle(
              color: Colors.orange,
              fontWeight: FontWeight.bold,
              fontSize: 24.sp , // You can replace this with 24.sp if needed
              letterSpacing: 1.2),
        ),
        centerTitle: true,
        scrolledUnderElevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder<List<Products>>(
              valueListenable: CartWidget.cartProductsNotifier,
              builder: (context, cartProducts, child) {
                if (cartProducts.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/8882813.jpg',
                          width: 150.w, // Use ScreenUtil for width
                          height: 150.h, // Use ScreenUtil for height
                        ),
                        const SizedBox(height: 20),
                         Text(
                          'Your cart is empty!',
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: cartProducts.length,
                  itemBuilder: (context, index) {
                    final product = cartProducts[index];
                    productQuantities.putIfAbsent(product, () => 1);

                    return Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 8.h, horizontal: 16.w), // Use ScreenUtil
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.r), // Use ScreenUtil
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(12.sp), // Use ScreenUtil
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.all(8.sp), // Use ScreenUtil
                              title: Text(
                                product.title ?? '',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18.sp, // Use ScreenUtil
                                ),
                              ),
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(10.r), // Use ScreenUtil
                                child: Image.network(
                                  product.images?.first ??
                                      'https://via.placeholder.com/150',
                                  width: 100.w, // Use ScreenUtil
                                  height: 100.h, // Use ScreenUtil
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.remove,
                                          color: Colors.orange),
                                      onPressed: () {
                                        setState(() {
                                          if (productQuantities[product]! > 1) {
                                            productQuantities[product] =
                                                productQuantities[product]! - 1;
                                          }
                                        });
                                      },
                                    ),
                                    Text(
                                      '${productQuantities[product]}',
                                      style: TextStyle(
                                        fontSize: 20.sp, // Use ScreenUtil
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.add,
                                          color: Colors.orange),
                                      onPressed: () {
                                        setState(() {
                                          productQuantities[product] =
                                              productQuantities[product]! + 1;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 16.w), // Use ScreenUtil
                                  child: Text(
                                    "\$${(product.price! * (productQuantities[product] ?? 1)).toStringAsFixed(2)}",
                                    style: TextStyle(
                                      color: Colors.orange,
                                      fontSize: 20.sp, // Use ScreenUtil
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                MaterialButton(
                                  onPressed: () {
                                    setState(() {
                                      CartWidget.removeProduct(product);
                                      productQuantities.remove(product);
                                    });
                                  },
                                  color: Colors.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.r), // Use ScreenUtil
                                  ),
                                  child: const Text(
                                    "Remove",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          ValueListenableBuilder<List<Products>>(
            valueListenable: CartWidget.cartProductsNotifier,
            builder: (context, cartProducts, child) {
              if (cartProducts.isNotEmpty) {
                final totalAmount = cartProducts.fold(
                  0.0,
                      (sum, product) =>
                  sum + (product.price ?? 0.0) * (productQuantities[product] ?? 1),
                );

                return Padding(
                  padding: EdgeInsets.all(16.sp), // Use ScreenUtil
                  child: Column(
                    children: [
                      Text(
                        'Total: \$${totalAmount.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: Colors.orange,
                          fontSize: 30.sp, // Use ScreenUtil
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      MaterialButton(
                        color: Colors.orange,
                        padding: EdgeInsets.symmetric(vertical: 12.sp, horizontal: 30.sp), // Use ScreenUtil
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r)), // Use ScreenUtil
                        child: Text(
                          "Order Now",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.sp), // Use ScreenUtil
                        ),
                        onPressed: () {
                          // Handle order now action
                        },
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                );
              } else {
                return Container(); // Don't show anything if the cart is empty
              }
            },
          ),
        ],
      ),
    );
  }
}
