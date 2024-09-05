import 'package:flutter/material.dart';
import '../../../data/models/Products.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cart Items',
          style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder<List<Products>>(
              valueListenable: CartWidget.cartProductsNotifier,
              builder: (context, cartProducts, child) {
                final totalAmount = cartProducts.fold(
                  0.0,
                      (sum, product) => sum + (product.price ?? 0.0),
                );

                if (cartProducts.isEmpty) {
                  return const Center(child: Text('No items in the cart.'));
                }
                return ListView.builder(
                  itemCount: cartProducts.length,
                  itemBuilder: (context, index) {
                    final product = cartProducts[index];
                    return SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          ListTile(
                            title: Text(
                              product.title ?? '',
                              style: const TextStyle(color: Colors.black),
                            ),
                            leading: Image.network(
                              product.images?.first ?? 'https://via.placeholder.com/150',
                              width: 150,
                              height: 150,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10, right: 20),
                                child: Text(
                                  "\$${product.price?.toStringAsFixed(2) ?? '0.00'}",
                                  style: const TextStyle(
                                    color: Colors.orange,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              MaterialButton(
                                onPressed: () {
                                  setState(() {
                                    CartWidget.removeProduct(product);
                                  });
                                },
                                color: Colors.orange,
                                child: const Text("Remove", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Divider(color: Colors.orange),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ValueListenableBuilder<List<Products>>(
              valueListenable: CartWidget.cartProductsNotifier,
              builder: (context, cartProducts, child) {
                final totalAmount = cartProducts.fold(
                  0.0,
                      (sum, product) => sum + (product.price ?? 0.0),
                );

                return Text(
                  'Total: \$${totalAmount.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: Colors.orange,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          MaterialButton(
            color: Colors.orange,
            child: const Text(
              "Order Now",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              // Handle order now action
            },
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}