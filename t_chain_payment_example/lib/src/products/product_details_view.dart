import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:t_chain_payment_example/src/widgets/bottom_bar.dart';
import 'package:t_chain_payment_example/src/widgets/shopping_cart_badge.dart';
import 'package:t_chain_payment_example/src/products/product.dart';
import 'package:t_chain_payment_example/src/products/products_controller.dart';
import 'package:t_chain_payment_example/src/cart/cart_controller.dart';
import 'package:t_chain_payment_example/utils/constants.dart';

/// Displays detailed information about a SampleItem.
class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({
    Key? key,
    required this.productID,
  }) : super(key: key);

  static const routeName = '/product_details';

  final String productID;

  @override
  Widget build(BuildContext context) {
    final product =
        context.read<ProductsController>().getProduct(id: productID);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Product Details'),
          actions: const [ShoppingCartBadge()],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: _buildProductDetail(context, product: product),
            ),
            _buildBottomBar(context, product: product),
          ],
        ));
  }

  Widget _buildProductDetail(BuildContext context, {Product? product}) {
    if (product == null) {
      return const Center(child: Text('Invalid Data'));
    }

    return Column(
      children: [
        SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(product.image),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Constants.hPadding),
                  child: Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Constants.hPadding),
                  child: Text('\$${product.price}'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar(BuildContext context, {Product? product}) {
    return BottomBar(
      child: SafeArea(
        child: ElevatedButton(
          onPressed: product == null
              ? null
              : () {
                  context.read<CartController>().add(product: product);
                },
          child: const Text('Add to Cart'),
        ),
      ),
    );
  }
}
