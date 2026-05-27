import 'package:flutter/foundation.dart';
import 'package:usedev_uninassau/src/models/cart_item_model.dart';
import 'package:usedev_uninassau/src/models/product_model.dart';

class CartService extends ChangeNotifier {
  CartService._();

  static final CartService instance = CartService._();

  final List<CartItemModel> _items = [];

  List<CartItemModel> get items => List.unmodifiable(_items);

  int get itemCount =>
      _items.fold(0, (total, item) => total + item.quantity);

  double get total =>
      _items.fold(0, (sum, item) => sum + item.subtotal);

  void addItem(ProductModel product) {
    final index = _items.indexWhere((item) => item.product.id == product.id);

    if (index >= 0) {
      final current = _items[index];
      _items[index] = CartItemModel(
        product: current.product,
        quantity: current.quantity + 1,
      );
    } else {
      _items.add(CartItemModel(product: product, quantity: 1));
    }

    notifyListeners();
  }

  void removeItem(int productId) {
    _items.removeWhere((item) => item.product.id == productId);
    notifyListeners();
  }

  void increment(int productId) {
    final index = _items.indexWhere((item) => item.product.id == productId);
    if (index < 0) return;

    final current = _items[index];
    _items[index] = CartItemModel(
      product: current.product,
      quantity: current.quantity + 1,
    );
    notifyListeners();
  }

  void decrement(int productId) {
    final index = _items.indexWhere((item) => item.product.id == productId);
    if (index < 0) return;

    final current = _items[index];
    if (current.quantity <= 1) {
      removeItem(productId);
      return;
    }

    _items[index] = CartItemModel(
      product: current.product,
      quantity: current.quantity - 1,
    );
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
