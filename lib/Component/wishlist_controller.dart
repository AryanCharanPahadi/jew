import 'package:flutter/material.dart';
import 'product_modal.dart';

class WishlistController extends ChangeNotifier {
  final List<Product> _likedProducts = [];

  List<Product> get likedProducts => List.unmodifiable(_likedProducts);

  void toggleLike(Product product) {
    if (_likedProducts.contains(product)) {
      _likedProducts.remove(product);
    } else {
      _likedProducts.add(product);
    }
    notifyListeners();
  }

  bool isLiked(Product product) {
    return _likedProducts.contains(product);
  }
}
