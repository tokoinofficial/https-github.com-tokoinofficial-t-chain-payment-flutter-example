import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:t_chain_payment_example/src/cart/cart_controller.dart';
import 'package:t_chain_payment_example/src/cart/cart_view.dart';

class ShoppingCartBadge extends StatelessWidget {
  const ShoppingCartBadge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CartController>(
      builder: (context, cart, child) {
        return Badge(
          position: BadgePosition.topStart(top: 0, start: -5),
          animationDuration: const Duration(milliseconds: 100),
          animationType: BadgeAnimationType.scale,
          badgeContent: Text(
            cart.totalItems.toString(),
            style: const TextStyle(color: Colors.white),
          ),
          child: child,
        );
      },
      child: IconButton(
        icon: const Icon(Icons.shopping_cart),
        onPressed: () {
          Navigator.restorablePushNamed(context, CartView.routeName);
        },
      ),
    );
  }
}
