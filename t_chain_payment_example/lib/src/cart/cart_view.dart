import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:t_chain_payment_example/src/cart/cart_controller.dart';
import 'package:t_chain_payment_example/src/checkout/checkout_view.dart';
import 'package:t_chain_payment_example/src/widgets/bottom_bar.dart';
import 'package:t_chain_payment_example/src/widgets/cart_stepper.dart';
import 'package:t_chain_payment_example/utils/formatter.dart';

class CartView extends StatelessWidget {
  const CartView({
    Key? key,
  }) : super(key: key);

  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              context.read<CartController>().removeAll();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildCart(),
          ),
          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildCart() {
    return Consumer<CartController>(
      builder: (BuildContext context, cart, Widget? child) {
        if (cart.items.isEmpty) {
          return const Center(
            child: Text(
              'Empty',
            ),
          );
        }
        return ListView.builder(
          restorationId: 'sampleItemListView',
          itemCount: cart.items.length,
          itemBuilder: (BuildContext context, int index) {
            final item = cart.items[index];

            return ListTile(
              title: Text(item.product.name),
              subtitle: Text(Formatter.format(money: item.product.price)),
              leading: CircleAvatar(
                foregroundImage: AssetImage(item.product.image),
              ),
              trailing: CartStepper(
                value: item.amount,
                onChanged: (value) => cart.adjust(
                  product: item.product,
                  amount: value,
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildBottomBar() {
    return BottomBar(
      child: SafeArea(
        child: Consumer<CartController>(
          builder: (BuildContext context, cart, Widget? child) {
            return Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Total'),
                      Text(
                        Formatter.format(money: cart.totalPrice),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: cart.items.isEmpty
                        ? null
                        : () => Navigator.of(context).restorablePushNamed(
                              CheckoutView.routeName,
                            ),
                    child: const Text('CONFIRM ORDER'),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
