import 'package:flutter/material.dart';
import 'package:t_chain_payment_example/src/products/product.dart';
import 'package:t_chain_payment_example/src/cart/cart_item.dart';

class CartController with ChangeNotifier {
  CartController();

  final List<CartItem> _items = [];
  List<CartItem> get items => _items;

  int get totalItems =>
      _items.fold(0, (previousValue, e) => previousValue + e.amount);

  double get totalPrice => _items.fold(
      0,
      (previousValue, e) =>
          previousValue + e.amount.toDouble() * e.product.price);

  add({required Product product}) {
    final index =
        _items.indexWhere((element) => element.product.id == product.id);

    if (index < 0) {
      // add new item
      _items.add(
        CartItem(product: product, amount: 1),
      );
    } else {
      final item = _items[index];
      final newItem = item.copyWith(amount: item.amount + 1);

      _items[index] = newItem;
    }

    notifyListeners();
  }

  adjust({required Product product, required int amount}) {
    final index =
        _items.indexWhere((element) => element.product.id == product.id);

    if (index < 0) return;

    if (amount <= 0) {
      _items.removeAt(index);
    } else {
      final item = _items[index];
      final newItem = item.copyWith(amount: amount);
      _items[index] = newItem;
    }

    notifyListeners();
  }

  remove({required Product product}) {
    final index = _items.indexWhere((element) => element == product);
    if (index < 0) return;

    _items.removeAt(index);

    notifyListeners();
  }

  removeAll() {
    _items.clear();
    notifyListeners();
  }

  Future<String> createOrder() async {
    // call API
    await Future.delayed(const Duration(seconds: 1));

    // return order ID
    return DateTime.now().microsecondsSinceEpoch.toString();
  }
}
