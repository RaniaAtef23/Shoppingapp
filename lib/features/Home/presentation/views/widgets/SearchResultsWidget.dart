// lib/widgets/search_results_widget.dart

import 'package:flutter/material.dart';
import 'package:shopping_app/features/Home/data/models/Products.dart';
import 'package:shopping_app/features/Home/presentation/views/details_screen.dart';

class SearchResultsWidget extends StatelessWidget {
  final List<Products> filteredProducts;
  final TextEditingController searchController;
  final Function(String) onSearchChanged;
  final VoidCallback onClose;

  const SearchResultsWidget({
    Key? key,
    required this.filteredProducts,
    required this.searchController,
    required this.onSearchChanged,
    required this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.9),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Enter product name',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: onClose,
                ),
              ),
              onChanged: onSearchChanged,
            ),
          ),
          Expanded(
            child: filteredProducts.isEmpty
                ? Center(child: Text('No products found.'))
                : ListView.builder(
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsScreen(product: product),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.network(
                          product.thumbnail ?? 'https://via.placeholder.com/150',
                          height: 40.0,
                          width: 40.0,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(width: 8.0),
                        Expanded(
                          child: Text(
                            product.title!,
                            overflow: TextOverflow.ellipsis, // Ensure long titles are truncated
                          ),
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text(
                            '\$${product.price.toString()}',
                            style: TextStyle(color: Colors.orange),
                          ),
                        ),
                        Divider(color: Colors.orange),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
