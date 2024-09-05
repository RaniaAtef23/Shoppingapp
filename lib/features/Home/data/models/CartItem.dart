
import 'package:shopping_app/features/Home/data/models/Products.dart';

class CartItem {
  final Products product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}