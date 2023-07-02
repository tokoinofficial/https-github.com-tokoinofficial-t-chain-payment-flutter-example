import 'package:flutter/material.dart';
import 'package:t_chain_payment_example/src/products/product.dart';
import 'package:t_chain_payment_example/src/products/products_service.dart';

class ProductsController with ChangeNotifier {
  ProductsController(this._productsService);
  final ProductsService _productsService;

  final List<Product> _items = [];
  List<Product> get items => _items;

  Future<void> loadData() async {
    final values = await _productsService.getProducts();
    _items.clear();
    _items.addAll(values);

    notifyListeners();
  }

  Product? getProduct({required String id}) {
    final p = _items.where((element) => element.id == id);

    if (p.isEmpty) return null;

    return p.first;
  }
}
